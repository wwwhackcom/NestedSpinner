//
//  NestedSpinnerAdapter.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

public class NestedSpinnerAdapter: NSObject {
    
    //MARK: - Init's
    private override init() {
        super.init()
    }
    
    public convenience init(_ style: NestedSpinnerStyle) {
        self.init()
        self.style = style
    }
    
    //MARK: - public properties
    
    // Data for Normal Spinner
    public var dataSource: NSArray? {
        didSet { deselectRows(at: selectedRowIndices) }
    }
    
    // Data for Nested Spinner
    public var dataTrees: [NestedSpinnerGroupItem]? {
        didSet { deselectRows(at: selectedRowIndices) }
    }
    
    public var valueConfiguration: ValueConfigurationClosure?
    public var customSectionConfiguration: SectionConfigurationClosure?
    public var customCellConfiguration: CellConfigurationClosure?
    public var selectionAction: SelectionAction?
    public var reloadSections: ReloadSection?
    
    weak var delegate: TableViewDelegate?
    var isNested: Bool { return dataTrees != nil && dataSource == nil }
    var dataSourceCount: Int { return dataSource?.count ?? 0 }
    var dataTreesCount: Int { return dataTrees?.count ?? 1 }
    var tableHeight: CGFloat { return getTableHeight() }
    
    //MARK: - private
    private var selectedRowIndices = Set<IndexPath>()
    private var style: NestedSpinnerStyle!
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension NestedSpinnerAdapter: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataTreesCount;
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (isNested ? style.sectionHeight : style.headerTopPadding)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.Header) as! NestedGroupItemCell
        configureSection(header, at: section)
        return header
    }
    
    public func configureSection(_ header: NestedGroupItemCell, at section: Int) {
        header.tintColor = style.tableViewBackgroundColor
        if !isNested {
            return;
        }
        
        header.delegate = self
        header.section = section
        header.bgViewPaddingTop.constant = style.headerTopPadding
        header.bgViewHeight.constant = style.sectionHeight - 2 * style.headerTopPadding
        header.labelTitle.font = style.sectionTextFont
        header.labelTitle.textColor = style.sectionTextColor
        header.labelTitle.textAlignment = style.sectionTextAlignment
        header.groupItem = getGroupItem(section)!
        
        let value = header.groupItem?.groupItemTitle ?? ""
        customSectionConfiguration?(section, value, header.groupItem, header)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNested {
            return dataTreesVisibleSubItemCount(section)
        } else {
            return dataSource?.count ?? 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.SpinnerCell, for: indexPath) as! NestedSpinnerCell
        configureCell(cell, indexPath)
        return cell
    }
    
    public func configureCell(_ cell: NestedSpinnerCell, _ indexPath: IndexPath) {
        cell.labelTitle.font = style.cellTextFont
        cell.labelTitle.textAlignment = style.cellTextAlignment
        cell.selectedBackgroundColor = style.selectionBackgroundColor
        cell.normalTextColor = style.cellTextColor
        cell.highlightTextColor = style.cellSelectedTextColor
        if let cellConfiguration = valueConfiguration {
            cell.labelTitle.text = cellConfiguration(indexPath.row, getSubItemTitle(indexPath))
        } else {
            cell.labelTitle.text = getSubItemTitle(indexPath)
        }
        
        customCellConfiguration?(indexPath.row, getSubItemTitle(indexPath), getSubItem(indexPath), cell)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if style.showCellSelection {
            cell.isSelected = selectedRowIndices.first{ $0 == indexPath } != nil
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowIndices.removeAll()
        selectedRowIndices.insert(indexPath)
        delegate?.selectAction(index: indexPath.row, value: getSubItemTitle(indexPath), userdata: getSubItem(indexPath))
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return style.footerBottomPadding
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.Footer)
        if (footer == nil) {
            footer = UITableViewHeaderFooterView(reuseIdentifier: NestedSpinnerConstants.PopupView.ReusableIdentifier.Footer)
        }
        footer?.contentView.backgroundColor = style.tableViewBackgroundColor
        return footer
    }
    
}


//MARK: - Data Handling
extension NestedSpinnerAdapter {
    
    private func getGroupItem(_ section: Int) -> NestedSpinnerGroupItem? {
        if !isNested || section < 0 || section >= dataTrees!.count { return nil }
        return dataTrees![section]
    }
    
    private func getSubItem(_ indexPath: IndexPath) -> AnyObject? {
        if isNested {
            return dataTreesSubItem(indexPath)
        } else {
            guard let subItem = dataSource?[indexPath.row] as? NestedSpinnerDataSource else { return nil }
            return subItem
        }
    }
    
    private func getSubItemTitle(_ indexPath: IndexPath) -> String {
        if isNested {
            let subItem = dataTreesSubItem(indexPath)
            return subItem?.getSubTitle() ?? ""
        } else {
            guard let subItem = dataSource?[indexPath.row] as? NestedSpinnerDataSource else { return "" }
            return subItem.getTitle()
        }
    }
    
    private func getTableHeight() -> CGFloat {
        if isNested {
            var height = CGFloat(0)
            dataTrees!.forEach {
                var heightSection = CGFloat(0)
                if !$0.isCollapsed {
                    heightSection = style.rowHeight * CGFloat($0.subItems.count) + style.sectionHeight + style.footerBottomPadding
                } else {
                    heightSection = style.sectionHeight + style.footerBottomPadding
                }
                height += heightSection
            }
            return height
        } else {
            return style.rowHeight * CGFloat(dataSource?.count ?? 1) + style.headerTopPadding + style.footerBottomPadding
        }
    }
    
    private func dataTreesSubItem(_ indexPath: IndexPath) -> NestedSpinnerSubItem? {
        guard let item = getGroupItem(indexPath.section) else { return nil }
        guard indexPath.row >= 0 && indexPath.row < item.subItems.count else { return nil }
        guard let subItem = item.subItems[indexPath.row] as? NestedSpinnerSubItem else { return nil }
        return subItem
    }
    
    private func dataTreesSubItemCount(_ section: Int) -> Int {
        let item = getGroupItem(section)
        return item?.subItems.count ?? 0
    }
    
    private func dataTreesVisibleSubItemCount(_ section: Int) -> Int {
        guard let item = getGroupItem(section) else { return 0 }
        return item.isCollapsed ? 0 : item.subItems.count
    }
    
}


//MARK: - Select Actions
extension NestedSpinnerAdapter {
    
    public func selectRow(at indexPath: IndexPath?, scrollPosition: UITableView.ScrollPosition = .none) {
        if let indexPath = indexPath {
            delegate?.selectItem(at: indexPath, animated: true, scrollPosition: scrollPosition)
            selectedRowIndices.insert(indexPath)
        } else {
            deselectRows(at: selectedRowIndices)
            selectedRowIndices.removeAll()
        }
    }
    
    public func deselectRow(at indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        
        if let selectedIndexPath = selectedRowIndices.firstIndex(where: { $0 == indexPath }) {
            selectedRowIndices.remove(at: selectedIndexPath)
        }

        delegate?.deselectItem(at: indexPath, animated: true)
    }
    
    public func selectRows(at indices: Set<IndexPath>?) {
        indices?.forEach {
            selectRow(at: $0)
        }
    }
    
    public func deselectRows(at indices: Set<IndexPath>?) {
        indices?.forEach {
            deselectRow(at: $0)
        }
    }
    
    public func clearSelection() {
        self.selectRow(at:nil)
    }
    
    public var indexPathForSelectedRow: NSIndexPath? {
        return delegate?.indexPathForSelectedItem() as NSIndexPath?
    }
    
    public var selectedItem: AnyObject? {
        guard let indexPath = (delegate?.indexPathForSelectedItem() as NSIndexPath?) else { return nil }
        return getSubItem(indexPath as IndexPath)
    }
    
}


//MARK: - NestedGroupItemCellDelegate
extension NestedSpinnerAdapter: NestedGroupItemCellDelegate {
    
    func toggleSection(header: NestedGroupItemCell, section: Int) {
        if let item: NestedSpinnerGroupItem = dataTrees?[section] {
            if item.isCollapsible {
                let collapsed = !item.isCollapsed
                item.isCollapsed = collapsed
                header.setCollapsed(collapsed: collapsed)
                reloadSections?(section)
            }
        }
    }
    
}

protocol TableViewDelegate: AnyObject {
    
    func selectAction(index: Int, value: String, userdata: AnyObject?)
    
    func selectItem(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition)
    
    func deselectItem(at indexPath: IndexPath, animated: Bool)
    
    func indexPathForSelectedItem() -> IndexPath?
    
}

