//
//  NestedSpinnerPopupView.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

public final class NestedSpinnerPopupView: UIView {
    
    //MARK: - Init's
    public convenience init() {
        self.init(frame: .zero)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: - public properties
    public weak var anchorViewRef: AnchorView? {
        didSet { setNeedsUpdateConstraints() }
    }
    public var cellNib: UINib? {
        didSet {
            tableView.register(cellNib, forCellReuseIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.SpinnerCell)
            templateCell = nil
            reloadAllComponents()
        }
    }
    public var sectionNib: UINib? {
        didSet {
            tableView.register(sectionNib, forHeaderFooterViewReuseIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.Header)
            templateSection = nil
            reloadAllComponents()
        }
    }
    public var dataSource: NSArray? {
        willSet { dataAdapter.dataSource = newValue }
        didSet { reloadAllComponents() }
    }
    public var dataTrees = [NestedSpinnerGroupItem]() {
        willSet { dataAdapter.dataTrees = newValue }
        didSet { reloadAllComponents() }
    }
    public var anchorOffset: CGPoint = .zero {
        didSet { setNeedsUpdateConstraints() }
    }
    public var width = CGFloat(0) {
        didSet { setNeedsUpdateConstraints() }
    }
    public var selectionAction: SelectionAction?
    public var cancelAction: CancelAction?
    public var valueConfiguration: ValueConfigurationClosure? {
        get { return dataAdapter.valueConfiguration }
        set { dataAdapter.valueConfiguration = newValue }
    }
    public var customSectionConfiguration: SectionConfigurationClosure? {
        get { return dataAdapter.customSectionConfiguration }
        set { dataAdapter.customSectionConfiguration = newValue }
    }
    public var customCellConfiguration: CellConfigurationClosure? {
        get { return dataAdapter.customCellConfiguration }
        set { dataAdapter.customCellConfiguration = newValue }
    }
    public var style = NestedSpinnerStyle(global: true)
    
    //MARK: - private
    private var dataAdapter: NestedSpinnerAdapter!
    private let dismissableView = UIView()
    private let tableViewContainer = UIView()
    private let tableView = UITableView()
    private var templateCell: NestedSpinnerCell!
    private var templateSection: NestedGroupItemCell!
    private var minHeight: CGFloat { return tableView.rowHeight }
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    private var xConstraint: NSLayoutConstraint!
    private var yConstraint: NSLayoutConstraint!
    private var paddingLeftConstraint, paddingRightConstraint, paddingTopConstraint, paddingBottomConstraint: NSLayoutConstraint!
    private var didSetupConstraints = false
    
}

//MARK: - Actions
extension NestedSpinnerPopupView {
    
    @discardableResult
    public func show(window: UIWindow? = nil, transform: CGAffineTransform? = nil, anchorPoint: CGPoint? = nil) -> (canBeDisplayed: Bool, offscreenHeight: CGFloat?) {

        setNeedsUpdateConstraints()

        let visibleWindow = window != nil ? window : UIWindow.visibleWindow()
        visibleWindow?.addSubview(self)
        visibleWindow?.bringSubviewToFront(self)

        self.translatesAutoresizingMaskIntoConstraints = false
        visibleWindow?.addUniversalConstraints(format: "|[popupView]|", views: ["popupView": self])

        let layout = computeMeasureContent()

        if !layout.canBeDisplayed {
            hide()
            return (layout.canBeDisplayed, layout.offscreenHeight)
        }

        isHidden = false
        
        if anchorPoint != nil {
            tableViewContainer.layer.anchorPoint = anchorPoint!
        }
        
        if transform != nil {
            tableViewContainer.transform = transform!
        } else {
            tableViewContainer.transform = style.downScaleTransform
        }

        layoutIfNeeded()

        UIView.animate(
            withDuration: style.animationduration,
            delay: 0,
            options: style.animationEntranceOptions,
            animations: { [weak self] in
                self?.setShownState()
            },
            completion: nil)

        accessibilityViewIsModal = true
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self)

        return (layout.canBeDisplayed, layout.offscreenHeight)
    }

    public func hide() {
        if isHidden {
            return
        }

        UIView.animate(
            withDuration: style.animationduration,
            delay: 0,
            options: style.animationExitOptions,
            animations: { [weak self] in
                self?.setHiddenState()
            },
            completion: { [weak self] finished in
                guard let `self` = self else { return }

                self.isHidden = true
                self.removeFromSuperview()
                UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: self)
        })
    }
    
    private func cancel() {
        hide()
        cancelAction?()
    }
    
    public func selectRow(_ indexPath: IndexPath, scrollPosition: UITableView.ScrollPosition = .none) {
        dataAdapter.selectRow(at:indexPath, scrollPosition: scrollPosition)
    }
    
    public func deselectRow(_ indexPath: IndexPath) {
        dataAdapter.deselectRow(at: indexPath)
    }
    public func clearSelection() {
        dataAdapter.selectRow(at:nil)
    }
    public var indexPathForSelectedRow: NSIndexPath? {
        return dataAdapter.indexPathForSelectedRow
    }
    public var selectedItem: AnyObject? {
        return dataAdapter.selectedItem
    }
    
    public func reloadAllComponents() {
        DispatchQueue.executeOnMainThread {
            self.tableView.reloadData()
            self.setNeedsUpdateConstraints()
        }
    }
    
    private func setHiddenState() {
        alpha = 0
    }

    private func setShownState() {
        alpha = 1
        tableViewContainer.transform = CGAffineTransform.identity
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)

        if view === dismissableView {
            cancel()
            return nil
        } else {
            return view
        }
    }
}

//MARK: - UI
extension NestedSpinnerPopupView {
    
    private func setup() {
        tableView.register(cellNib, forCellReuseIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.SpinnerCell)
        tableView.register(sectionNib, forCellReuseIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.Header)

        DispatchQueue.main.async {
            self.updateConstraintsIfNeeded()
            self.setupUI()
        }

        tableView.rowHeight = style.rowHeight
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.sectionHeaderHeight = style.sectionHeight
        setHiddenState()
        isHidden = true

        dataAdapter = NestedSpinnerAdapter(style)
        dataAdapter.delegate = self
        dataAdapter.reloadSections = { [weak self] (section: Int) in
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([section], with: .fade)
            self?.tableView.endUpdates()
            self?.setNeedsUpdateConstraints()
        }
        
        tableView.delegate = dataAdapter
        tableView.dataSource = dataAdapter

        accessibilityIdentifier = NestedSpinnerConstants.PopupView.AccessibilityIdentifier
    }

    private func setupUI() {
        super.backgroundColor = .clear
        tableViewContainer.backgroundColor = style.popBackgroundColor
        tableViewContainer.layer.masksToBounds = false
        tableViewContainer.layer.cornerRadius = style.cornerRadius
        tableViewContainer.layer.shadowColor = style.shadowColor.cgColor
        tableViewContainer.layer.shadowOffset = style.shadowOffset
        tableViewContainer.layer.shadowOpacity = style.shadowOpacity
        tableViewContainer.layer.shadowRadius = style.shadowRadius

        tableView.backgroundColor = style.tableViewBackgroundColor
        tableView.separatorColor = style.separatorColor
        tableView.layer.cornerRadius = style.cornerRadius
        tableView.layer.masksToBounds = true
    }
    
    public override func updateConstraints() {
        if !didSetupConstraints {
            setupConstraints()
        }

        didSetupConstraints = true

        let layout = computeMeasureContent()

        if !layout.canBeDisplayed {
            super.updateConstraints()
            hide()

            return
        }
        
        xConstraint.constant = layout.x
        yConstraint.constant = layout.y
        widthConstraint.constant = layout.width
        heightConstraint.constant = layout.visibleHeight
        
        paddingTopConstraint.constant = style.innerPaddingTop
        paddingLeftConstraint.constant = style.innerPaddingLeft
        paddingRightConstraint.constant = -style.innerPaddingRight
        paddingBottomConstraint.constant = -style.innerPaddingBottom

        tableView.isScrollEnabled = layout.offscreenHeight > 0

        DispatchQueue.main.async { [weak self] in
            self?.tableView.flashScrollIndicators()
        }

        super.updateConstraints()
    }

    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(dismissableView)
        dismissableView.translatesAutoresizingMaskIntoConstraints = false
        addUniversalConstraints(format: "|[dismissableView]|", views: ["dismissableView": dismissableView])

        addSubview(tableViewContainer)
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false

        xConstraint = NSLayoutConstraint(
            item: tableViewContainer,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1,
            constant: 0)
        addConstraint(xConstraint)

        yConstraint = NSLayoutConstraint(
            item: tableViewContainer,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        addConstraint(yConstraint)

        widthConstraint = NSLayoutConstraint(
            item: tableViewContainer,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0)
        tableViewContainer.addConstraint(widthConstraint)

        heightConstraint = NSLayoutConstraint(
            item: tableViewContainer,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0)
        tableViewContainer.addConstraint(heightConstraint)

        tableViewContainer.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        setupTableViewContainer()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsUpdateConstraints()
        let shadowPath = UIBezierPath(roundedRect: tableViewContainer.bounds, cornerRadius: style.cornerRadius)
        tableViewContainer.layer.shadowPath = shadowPath.cgPath
    }
    
    private func setupTableViewContainer() {
        
        paddingTopConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .top,
            relatedBy: .equal,
            toItem: tableViewContainer,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        tableViewContainer.addConstraint(paddingTopConstraint)
        
        paddingLeftConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: tableViewContainer,
            attribute: .leading,
            multiplier: 1,
            constant: 0)
        tableViewContainer.addConstraint(paddingLeftConstraint)
        
        paddingRightConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: tableViewContainer,
            attribute: .trailing,
            multiplier: 1,
            constant: 0)
        tableViewContainer.addConstraint(paddingRightConstraint)
        
        paddingBottomConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: tableViewContainer,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
        tableViewContainer.addConstraint(paddingBottomConstraint)
    }
    
    private func computeMeasureContent() -> (x: CGFloat, y: CGFloat, width: CGFloat, offscreenHeight: CGFloat, visibleHeight: CGFloat, canBeDisplayed: Bool) {
        var layout: ComputeLayoutTuple = (0, 0, 0, 0)
        
        guard let window = UIWindow.visibleWindow() else { return (0, 0, 0, 0, 0, false) }
        
        layout = computeMeasureLayoutBottom(window: window)
        
        constraintWidthToFittingSizeIfNecessary(layout: &layout)
        constraintWidthToBoundsIfNecessary(layout: &layout, in: window)
        
        let visibleHeight = dataAdapter.tableHeight + style.innerPaddingTop + style.innerPaddingBottom - layout.offscreenHeight
        let canBeDisplayed = visibleHeight >= minHeight

        return (layout.x, layout.y, layout.width, layout.offscreenHeight, visibleHeight, canBeDisplayed)
    }
    
    private func computeMeasureLayoutBottom(window: UIWindow) -> ComputeLayoutTuple {
        var offscreenHeight: CGFloat = 0
        
        let width = self.width != CGFloat(0) ?  self.width : (anchorViewRef?.instance.bounds.width ?? fittingWidth()) - anchorOffset.x
        
        let anchorViewX = anchorViewRef?.instance.windowFrame?.minX ?? window.frame.midX - (width / 2)
        let anchorViewY = anchorViewRef?.instance.windowFrame?.minY ?? window.frame.midY - (dataAdapter.tableHeight / 2)
        
        let x = anchorViewX + anchorOffset.x
        let y = anchorViewY + anchorOffset.y
        
        let maxY = y + dataAdapter.tableHeight + style.innerPaddingTop + style.innerPaddingBottom
        let windowMaxY = window.bounds.maxY - style.paddingBottom
        if maxY > windowMaxY {
            offscreenHeight = abs(maxY - windowMaxY)
        }
        return (x, y, width, offscreenHeight)
    }
    
    private func fittingWidth() -> CGFloat {
        var maxWidth: CGFloat = 0
        if dataAdapter.isNested {
            if templateSection == nil {
                templateSection = (sectionNib?.instantiate(withOwner: nil, options: nil)[0] as! NestedGroupItemCell)
            }
            
            if templateCell == nil {
                templateCell = (cellNib?.instantiate(withOwner: nil, options: nil)[0] as! NestedSpinnerCell)
            }
            
            for section in 0..<dataAdapter.dataTreesCount {
                var maxWidthSetion: CGFloat = 0
                dataAdapter.configureSection(templateSection, at: section)
                templateSection.bounds.size.height = style.sectionHeight
                let item: NestedSpinnerGroupItem = dataAdapter.dataTrees![section] as NestedSpinnerGroupItem
                for index in 0..<item.subItems.count {
                    dataAdapter.configureCell(templateCell, IndexPath(row: index, section: section))
                    templateCell.bounds.size.height = style.rowHeight
                    let width = templateCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
                    if width > maxWidthSetion {
                        maxWidthSetion = width
                    }
                }
                if maxWidthSetion > maxWidth {
                    maxWidth = maxWidthSetion
                }
            }
        } else {
            if templateCell == nil {
                templateCell = (cellNib?.instantiate(withOwner: nil, options: nil)[0] as! NestedSpinnerCell)
            }
            
            for index in 0..<dataAdapter.dataSourceCount {
                dataAdapter.configureCell(templateCell, IndexPath(row: index, section: 0))
                templateCell.bounds.size.height = style.rowHeight
                let width = templateCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
                
                if width > maxWidth {
                    maxWidth = width
                }
            }
        }
        return maxWidth
    }
    
    private func constraintWidthToBoundsIfNecessary(layout: inout ComputeLayoutTuple, in window: UIWindow) {
        let windowMaxX = window.bounds.maxX
        let maxX = layout.x + layout.width
        
        if maxX > windowMaxX {
            let delta = maxX - windowMaxX
            let newOrigin = layout.x - delta
            
            if newOrigin > 0 {
                layout.x = newOrigin
            } else {
                layout.x = 0
                layout.width += newOrigin
            }
        }
    }
    
    private func constraintWidthToFittingSizeIfNecessary(layout: inout ComputeLayoutTuple) {
        guard width == CGFloat(0) else { return }
        
        if layout.width < fittingWidth() {
            layout.width = fittingWidth()
        }
    }
    
}

//MARK: - TableViewDelegate
extension NestedSpinnerPopupView: TableViewDelegate {
    
    func selectAction(indexPath: IndexPath, value: String, userdata: AnyObject?) {
        selectionAction?(indexPath, value, userdata)
        hide()
    }
    
    func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition) {
        tableView.selectRow(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    func deselectItem(at indexPath: IndexPath, animated: Bool) {
        tableView.deselectRow(at: indexPath, animated: animated)
    }
    
    func indexPathForSelectedItem() -> IndexPath? {
        return tableView.indexPathForSelectedRow
    }
    
}
