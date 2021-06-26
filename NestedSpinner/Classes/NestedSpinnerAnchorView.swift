//
//  NestedSpinnerAnchorView.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

@objc public protocol AnchorView: AnyObject {
    
    var instance: UIView { get }
    
}

extension UIView: AnchorView {
    
    public var instance: UIView {
        return self
    }
    
}

@IBDesignable
open class NestedSpinnerAnchorView : UIView {
    
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
    @objc public var willClickAction: AnchorTapAction?
    @objc public var didClickAction: AnchorTapAction?
    
    @objc public dynamic var anchorValue: String? {
        get { return labelValue.text }
        set { labelValue.text = newValue! }
    }
    
    @objc @IBInspectable public dynamic var anchorTintColor = NestedSpinnerConstants.AnchorView.TintColor {
        willSet {
            labelValue.textColor = newValue
            ivAccessory.tintColor = newValue
        }
    }
    
    @objc @IBInspectable public dynamic var anchorTextFont = NestedSpinnerConstants.AnchorView.TextFont {
        willSet { labelValue.font = newValue }
    }
    
    @objc @IBInspectable public dynamic var accessoryImage = NestedSpinnerConstants.AnchorView.AccessoryImage {
        willSet {
            let tintableImage = newValue?.withRenderingMode(.alwaysTemplate)
            ivAccessory.image = tintableImage
        }
    }
    
    internal var clickAction : AnchorTapAction?
    
    //MARK: - private
    private let labelValue = UILabel()
    private let ivAccessory = UIImageView()
    
}

//MARK: - UI
extension NestedSpinnerAnchorView {
    
    private func setup() {
        backgroundColor = .clear
        addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(tapAnchorView(_:))))
        isUserInteractionEnabled = true
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        ivAccessory.translatesAutoresizingMaskIntoConstraints = false
        let tintableImage = accessoryImage?.withRenderingMode(.alwaysTemplate)
        ivAccessory.image = tintableImage
        ivAccessory.tintColor = anchorTintColor
        addSubview(labelValue)
        addSubview(ivAccessory)
        
        let metric = ["space": 4]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[labelValue]-space-[ivAccessory(22)]-space-|", options: NSLayoutConstraint.FormatOptions(), metrics: metric, views: ["labelValue" : labelValue, "ivAccessory" : ivAccessory]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[labelValue]-space-|", options: NSLayoutConstraint.FormatOptions(), metrics: metric, views: ["labelValue" : labelValue]))
        ivAccessory.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivAccessory.heightAnchor.constraint(equalToConstant: 22).isActive = true
        labelValue.text = "Select..."
        labelValue.textColor = anchorTintColor
        labelValue.font = anchorTextFont
    }
    
    @objc private func tapAnchorView(_ sender: UITapGestureRecognizer) {
        willClickAction?()
        clickAction?()
        didClickAction?()
    }
}
