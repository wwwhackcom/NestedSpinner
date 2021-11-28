//
//  NestedSpinnerView.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

@IBDesignable
open class NestedSpinnerView: NestedSpinnerAnchorView {
    
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
    @objc public var selectionAction: SelectionAction?
    @objc public var cancelAction: CancelAction?
    @objc public var cellConfiguration: ValueConfigurationClosure?
    @objc public var customisedCellConfiguration: CellConfigurationClosure?
    @objc public var customisedSectionConfiguration: SectionConfigurationClosure?
    
    @objc public weak var anchorView: AnchorView? {
        willSet {
            self.isHidden = true
            popupView.anchorViewRef = newValue
        }
    }
    @objc public dynamic var popupViewWidth: CGFloat {
        get { return popupView.width }
        set { popupView.width = newValue }
    }
    @objc public dynamic var anchorOffset: CGPoint {
        get { popupView.anchorOffset }
        set { popupView.anchorOffset = newValue }
    }
    @objc public dynamic var style: NestedSpinnerStyle {
        get { return popupView.style }
        set { popupView.style = newValue }
    }
    @objc public dynamic var cellNib = UINib(nibName: String(describing: NestedSpinnerCell.self), bundle: NestedSpinnerBundle.bundle) {
        willSet { popupView.cellNib = newValue }
    }
    @objc public dynamic var sectionNib = UINib(nibName: String(describing: NestedGroupItemCell.self), bundle: NestedSpinnerBundle.bundle) {
        willSet { popupView.sectionNib = newValue }
    }
    @objc public dynamic var dataSource: NSArray? {
        get { return popupView.dataSource }
        set { popupView.dataSource = newValue }
    }
    @objc public dynamic var dataTrees: [NestedSpinnerGroupItem] {
        get { return popupView.dataTrees }
        set { popupView.dataTrees = newValue }
    }
    
    //MARK: - private
    private let popupView = NestedSpinnerPopupView()
    
}

//MARK: - Actions
extension NestedSpinnerView {
    
    @objc public func show() {
        if !popupView.isHidden {
            return
        }
        
        popupView.show(window: nil, transform: nil, anchorPoint: nil)
    }
    @objc public func hide() {
        popupView.hide()
    }
    @objc public func isShowing() -> Bool {
        return !popupView.isHidden
    }
    @objc public func selectRow(_ indexPath: IndexPath, scrollPosition: UITableView.ScrollPosition = .none) {
        popupView.selectRow(indexPath, scrollPosition: scrollPosition)
    }
    @objc public func deselectRow(_ indexPath: IndexPath) {
        popupView.deselectRow(indexPath)
    }
    @objc public func clearSelection() {
        popupView.clearSelection()
    }
    @objc public var indexPathForSelectedRow: NSIndexPath? {
        return popupView.indexPathForSelectedRow
    }
    @objc public var selectedItem: AnyObject? {
        return popupView.selectedItem
    }
    @objc public func reload() {
        popupView.reloadAllComponents()
    }
    
}

//MARK: - UI
extension NestedSpinnerView {
    
    private func setup() {
        popupView.anchorViewRef = self
        popupView.cellNib = cellNib
        popupView.sectionNib = sectionNib
        popupView.selectionAction = { index, value, userdata in
            if self.anchorView == nil {
                self.anchorValue = value
            }
            self.selectionAction?(index, value, userdata)
        }
        popupView.cancelAction = {
            self.cancelAction?()
        }
        popupView.valueConfiguration = { index, value in
            return self.cellConfiguration?(index, value) ?? value
        }
        popupView.customisedSectionConfiguration = { section, value, groupItem, sectionView in
            self.customisedSectionConfiguration?(section, value, groupItem, sectionView)
        }
        popupView.customisedCellConfiguration = { index, value, userdata, cell in
            self.customisedCellConfiguration?(index, value, userdata, cell)
        }
        clickAction = {
            self.popupView.show()
        }
    }
    
}
