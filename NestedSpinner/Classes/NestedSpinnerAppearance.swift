//
//  NestedSpinnerAppearance.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

@objcMembers
public class NestedSpinnerAppearance: NSObject {
    
    public class globalStyle {
        public static var popBackgroundColor = NestedSpinnerConstants.PopupView.BackgroundColor
        public static var tableViewBackgroundColor = NestedSpinnerConstants.PopupView.TableBackgroundColor
        public static var selectionBackgroundColor = NestedSpinnerConstants.PopupView.SelectionBackgroundColor
        public static var paddingBottom = NestedSpinnerConstants.PopupView.paddingBottom
        public static var innerPaddingTop = NestedSpinnerConstants.PopupView.InnerPaddingTop
        public static var innerPaddingLeft = NestedSpinnerConstants.PopupView.InnerPaddingLeft
        public static var innerPaddingRight = NestedSpinnerConstants.PopupView.InnerPaddingRight
        public static var innerPaddingBottom = NestedSpinnerConstants.PopupView.InnerPaddingBottom
        public static var cornerRadius = NestedSpinnerConstants.PopupView.CornerRadius
        public static var shadowColor = NestedSpinnerConstants.PopupView.Shadow.Color
        public static var shadowOffset = NestedSpinnerConstants.PopupView.Shadow.Offset
        public static var shadowOpacity = NestedSpinnerConstants.PopupView.Shadow.Opacity
        public static var shadowRadius = NestedSpinnerConstants.PopupView.Shadow.Radius
        public static var sectionHeight = NestedSpinnerConstants.PopupView.SectionHeight
        public static var rowHeight = NestedSpinnerConstants.PopupView.RowHeight
        public static var separatorColor = NestedSpinnerConstants.PopupView.SeparatorColor
        public static var headerTopPadding = NestedSpinnerConstants.PopupView.HeaderTopPadding
        public static var footerBottomPadding = NestedSpinnerConstants.PopupView.FooterBottomPadding
        public static var cellTextColor = NestedSpinnerConstants.PopupView.CellTextColor
        public static var cellSelectedTextColor = NestedSpinnerConstants.PopupView.CellSelectedTextColor
        public static var cellTextFont = NestedSpinnerConstants.PopupView.CellTextFont
        public static var cellTextAlignment = NestedSpinnerConstants.PopupView.CellTextAlignment
        public static var showCellSelection = NestedSpinnerConstants.PopupView.ShowCellSelection
        public static var sectionTextColor = NestedSpinnerConstants.PopupView.SectionTextColor
        public static var sectionTextFont = NestedSpinnerConstants.PopupView.CellTextFont
        public static var animationduration = NestedSpinnerConstants.PopupView.Animation.Duration
        public static var animationEntranceOptions = NestedSpinnerConstants.PopupView.Animation.EntranceOptions
        public static var animationExitOptions = NestedSpinnerConstants.PopupView.Animation.ExitOptions
        public static var downScaleTransform = NestedSpinnerConstants.PopupView.Animation.DownScaleTransform
    }
}

//MARK: - Builtin style
public extension NestedSpinnerAppearance {
    
    static func light() {
        globalStyle.popBackgroundColor = .white
        globalStyle.selectionBackgroundColor = UIColor(white: 0.5, alpha: 0.2)
        globalStyle.cornerRadius = 10
        globalStyle.shadowColor = UIColor(white: 0, alpha: 0.5)
        globalStyle.shadowOpacity = 0.9
        globalStyle.shadowRadius = 6
        globalStyle.animationduration = 0.25
    }
    
    static func dark() {
        globalStyle.popBackgroundColor = .black;
        globalStyle.tableViewBackgroundColor = .black;
        globalStyle.selectionBackgroundColor = UIColor(white: 0.5, alpha: 0.2)
        globalStyle.paddingBottom = 100
        globalStyle.innerPaddingTop = 3
        globalStyle.innerPaddingBottom = 3
        globalStyle.cornerRadius = 10
        globalStyle.shadowColor = UIColor(white: 0, alpha: 0.5)
        globalStyle.shadowOpacity = 0.9
        globalStyle.shadowRadius = 6
        globalStyle.cellTextColor = .white
        globalStyle.cellSelectedTextColor = .lightText
        globalStyle.cellTextFont = UIFont.boldSystemFont(ofSize: 17)
        globalStyle.cellTextAlignment = .center
        
        globalStyle.animationduration = 0.25
    }
    
    static func darkNested() {
        globalStyle.popBackgroundColor = .black
        globalStyle.tableViewBackgroundColor = .black
        globalStyle.selectionBackgroundColor = UIColor(white: 0.5, alpha: 0.2)
        globalStyle.innerPaddingTop = 6
        globalStyle.innerPaddingLeft = 3
        globalStyle.innerPaddingRight = 3
        globalStyle.innerPaddingBottom = 0
        globalStyle.cornerRadius = 10
        globalStyle.shadowColor = UIColor(white: 0, alpha: 0.5)
        globalStyle.shadowOpacity = 0.9
        globalStyle.shadowRadius = 6
        globalStyle.sectionHeight = 50;
        globalStyle.headerTopPadding = 3
        globalStyle.footerBottomPadding = 3
        globalStyle.cellTextColor = .white
        globalStyle.cellSelectedTextColor = .lightText
        globalStyle.cellTextFont = UIFont.boldSystemFont(ofSize: 16)
        
        globalStyle.sectionTextColor = .white
        globalStyle.sectionTextFont = UIFont.boldSystemFont(ofSize: 18)
        
        globalStyle.animationduration = 0.25
    }
    
}

//MARK: - Customised style
public extension NestedSpinnerAppearance {
    
    static func customised(_ closure: AppearanceCustomisedClosure?) {
        closure?()
    }
    
}

