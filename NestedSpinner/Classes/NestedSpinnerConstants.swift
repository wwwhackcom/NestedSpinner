//
//  NestedSpinnerConstants.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

internal struct NestedSpinnerConstants {

    internal struct AnchorView {
        
        static let TintColor = UIColor.darkText
        static let TextFont = UIFont.systemFont(ofSize: 17)
        static let AccessoryImage = UIImage(named: "ic_arrow_down1", in: NestedSpinnerBundle.bundle, compatibleWith: nil)
        
    }
    
    internal struct PopupView {
        
        static let BackgroundColor = UIColor(white: 0.94, alpha: 1)
        static let TableBackgroundColor = UIColor(white: 0.94, alpha: 1)
        static let paddingBottom: CGFloat = 20
        static let InnerPaddingTop: CGFloat = 0
        static let InnerPaddingLeft: CGFloat = 0
        static let InnerPaddingRight: CGFloat = 0
        static let InnerPaddingBottom: CGFloat = 0
        static let CornerRadius: CGFloat = 5
        static let SectionHeight: CGFloat = 54
        static let RowHeight: CGFloat = 44
        static let SeparatorColor = UIColor.clear
        static let HeaderTopPadding: CGFloat = 0
        static let FooterBottomPadding: CGFloat = 0
        static let CellCornerRadius: CGFloat = 5
        static let CellBackgroundColor = UIColor.white
        static let CellSelectedBackgroundColor = UIColor(white: 0.89, alpha: 1)
        static let ShowCellSelection = false
        static let CellTextColor = UIColor.black
        static let CellSelectedTextColor = UIColor.black
        static let CellTextFont = UIFont.systemFont(ofSize: 16)
        static let CellTextAlignment = NSTextAlignment.left
        static let SectionCornerRadius: CGFloat = 5
        static let SectionBackgroundColor = UIColor(red: 39.0/255.0, green: 39.0/255.0, blue: 39.0/255.0, alpha: 1)
        static let SectionTextColor = UIColor.black
        static let SectionTextFont = UIFont.boldSystemFont(ofSize: 18)
        static let SectionTextAlignment = NSTextAlignment.left
        
        struct Shadow {
            static let Color = UIColor.darkGray
            static let Offset = CGSize.zero
            static let Opacity: Float = 0.4
            static let Radius: CGFloat = 8
        }
        
        struct Animation {
            static let Duration = 0.15
            static let EntranceOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
            static let ExitOptions: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseIn]
            static let DownScaleTransform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        struct ReusableIdentifier {
            static let SpinnerCell = "SpinnerCell"
            static let Header = "HeaderView"
            static let Footer = "FooterView"
        }
        
        struct Image {
            static let Down = UIImage(named: "ic_arrow_down", in: NestedSpinnerBundle.bundle, compatibleWith: nil)
            static let Right = UIImage(named: "ic_arrow_right", in: NestedSpinnerBundle.bundle, compatibleWith: nil)
        }
        
        static let AccessibilityIdentifier = "nested_spinner"
        
    }

}

@objcMembers
public class NestedSpinnerBundle: NSObject {
    
    public static var bundle: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        let podBundle = Bundle(for: NestedSpinnerView.self)
        guard let url = podBundle.url(forResource: "NestedSpinner", withExtension: "bundle") else { return podBundle }
        guard let bundle = Bundle(url: url) else { return podBundle }
        return bundle
        #endif
    }
    
}
