//
//  NestedSpinnerStyle.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

@objcMembers
public class NestedSpinnerStyle: NSObject, InitializableClass {
    
    /// The background color of the popup
    public var popBackgroundColor = NestedSpinnerConstants.PopupView.BackgroundColor
    /// The background color of the table
    public var tableViewBackgroundColor = NestedSpinnerConstants.PopupView.TableBackgroundColor
    /// The popup view padding bottom of the current window
    public var paddingBottom = NestedSpinnerConstants.PopupView.paddingBottom
    /// The inner padding top of the table from the popup view
    public var innerPaddingTop = NestedSpinnerConstants.PopupView.InnerPaddingTop
    /// The inner padding left of the table from the popup view
    public var innerPaddingLeft = NestedSpinnerConstants.PopupView.InnerPaddingLeft
    /// The inner padding right of the table from the popup view
    public var innerPaddingRight = NestedSpinnerConstants.PopupView.InnerPaddingRight
    /// The inner padding bottom of the table from the popup view
    public var innerPaddingBottom = NestedSpinnerConstants.PopupView.InnerPaddingBottom
    /// The corner radius of popup view
    public var cornerRadius = NestedSpinnerConstants.PopupView.CornerRadius
    /// The color of the shadow
    public var shadowColor = NestedSpinnerConstants.PopupView.Shadow.Color
    /// The offset of the shadow.
    public var shadowOffset = NestedSpinnerConstants.PopupView.Shadow.Offset
    /// The opacity of the shadow
    public var shadowOpacity = NestedSpinnerConstants.PopupView.Shadow.Opacity
    /// The radius of the shadow
    public var shadowRadius = NestedSpinnerConstants.PopupView.Shadow.Radius
    
    /// The section height
    public var sectionHeight = NestedSpinnerConstants.PopupView.SectionHeight
    /// The row height of cell items
    public var rowHeight = NestedSpinnerConstants.PopupView.RowHeight
    /// The separator color between cell items
    public var separatorColor = NestedSpinnerConstants.PopupView.SeparatorColor
    /// The top padding of the header of the section
    public var headerTopPadding = NestedSpinnerConstants.PopupView.HeaderTopPadding
    /// The bottom padding of the footer of the section
    public var footerBottomPadding = NestedSpinnerConstants.PopupView.FooterBottomPadding
    /// The corner radius of cell item
    public var cellCornerRadius = NestedSpinnerConstants.PopupView.CellCornerRadius
    /// The background color for each cell item
    public var cellBackgroundColor = NestedSpinnerConstants.PopupView.CellBackgroundColor
    /// The background color of the selected cell item.
    public var cellSelectedBackgroundColor = NestedSpinnerConstants.PopupView.CellSelectedBackgroundColor
    /// If need to show cell selection
    public var showCellSelection = NestedSpinnerConstants.PopupView.ShowCellSelection
    /// The color of the text for each cell item
    public var cellTextColor = NestedSpinnerConstants.PopupView.CellTextColor
    /// The color of the text for selected cell item
    public var cellSelectedTextColor = NestedSpinnerConstants.PopupView.CellSelectedTextColor
    /// The font of the text for each cell item
    public var cellTextFont = NestedSpinnerConstants.PopupView.CellTextFont
    /// The text alignment of cell item
    public var cellTextAlignment = NestedSpinnerConstants.PopupView.CellTextAlignment
    /// The corner radius of section item
    public var sectionCornerRadius = NestedSpinnerConstants.PopupView.SectionCornerRadius
    /// The background color for each section item
    public var sectionBackgroundColor = NestedSpinnerConstants.PopupView.SectionBackgroundColor
    /// The color of the text for each section item
    public var sectionTextColor = NestedSpinnerConstants.PopupView.SectionTextColor
    /// The font of the text for each section item
    public var sectionTextFont = NestedSpinnerConstants.PopupView.CellTextFont
    /// The text alignment of section item
    public var sectionTextAlignment = NestedSpinnerConstants.PopupView.CellTextAlignment
    /// The duration of the show/hide animation
    
    public var animationduration = NestedSpinnerConstants.PopupView.Animation.Duration
    /// The option of the show animation
    public var animationEntranceOptions = NestedSpinnerConstants.PopupView.Animation.EntranceOptions
    /// The option of the hide animation
    public var animationExitOptions = NestedSpinnerConstants.PopupView.Animation.ExitOptions
    /// The downScale transformation
    public var downScaleTransform = NestedSpinnerConstants.PopupView.Animation.DownScaleTransform
    
    required public override init() {
    }
    
    public convenience init(global: Bool = true) {
        self.init()
        popBackgroundColor = NestedSpinnerAppearance.globalStyle.popBackgroundColor
        tableViewBackgroundColor = NestedSpinnerAppearance.globalStyle.tableViewBackgroundColor
        paddingBottom = NestedSpinnerAppearance.globalStyle.paddingBottom
        innerPaddingTop = NestedSpinnerAppearance.globalStyle.innerPaddingTop
        innerPaddingLeft = NestedSpinnerAppearance.globalStyle.innerPaddingLeft
        innerPaddingRight = NestedSpinnerAppearance.globalStyle.innerPaddingRight
        innerPaddingBottom = NestedSpinnerAppearance.globalStyle.innerPaddingBottom
        cornerRadius = NestedSpinnerAppearance.globalStyle.cornerRadius
        shadowColor = NestedSpinnerAppearance.globalStyle.shadowColor
        shadowOffset = NestedSpinnerAppearance.globalStyle.shadowOffset
        shadowOpacity = NestedSpinnerAppearance.globalStyle.shadowOpacity
        shadowRadius = NestedSpinnerAppearance.globalStyle.shadowRadius
        sectionHeight = NestedSpinnerAppearance.globalStyle.sectionHeight
        rowHeight = NestedSpinnerAppearance.globalStyle.rowHeight
        separatorColor = NestedSpinnerAppearance.globalStyle.separatorColor
        headerTopPadding = NestedSpinnerAppearance.globalStyle.headerTopPadding
        footerBottomPadding = NestedSpinnerAppearance.globalStyle.footerBottomPadding
        cellCornerRadius = NestedSpinnerAppearance.globalStyle.cellCornerRadius
        cellBackgroundColor = NestedSpinnerAppearance.globalStyle.cellBackgroundColor
        cellSelectedBackgroundColor = NestedSpinnerAppearance.globalStyle.cellSelectedBackgroundColor
        showCellSelection = NestedSpinnerAppearance.globalStyle.showCellSelection
        cellTextColor = NestedSpinnerAppearance.globalStyle.cellTextColor
        cellSelectedTextColor = NestedSpinnerAppearance.globalStyle.cellSelectedTextColor
        cellTextFont = NestedSpinnerAppearance.globalStyle.cellTextFont
        cellTextAlignment = NestedSpinnerAppearance.globalStyle.cellTextAlignment
        sectionCornerRadius = NestedSpinnerAppearance.globalStyle.sectionCornerRadius
        sectionBackgroundColor = NestedSpinnerAppearance.globalStyle.sectionBackgroundColor
        sectionTextColor = NestedSpinnerAppearance.globalStyle.sectionTextColor
        sectionTextFont = NestedSpinnerAppearance.globalStyle.sectionTextFont
        animationduration = NestedSpinnerAppearance.globalStyle.animationduration
        animationEntranceOptions = NestedSpinnerAppearance.globalStyle.animationEntranceOptions
        animationExitOptions = NestedSpinnerAppearance.globalStyle.animationExitOptions
        downScaleTransform = NestedSpinnerAppearance.globalStyle.downScaleTransform
    }
    
}

