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
    
    @objc @IBInspectable public dynamic var anchorAccessoryImage = NestedSpinnerConstants.AnchorView.AccessoryImage {
        willSet {
            let tintableImage = newValue?.withRenderingMode(.alwaysTemplate)
            ivAccessory.image = tintableImage
        }
    }
    
    @objc public dynamic var anchorPadding: CGFloat = 4.0 {
        didSet {
            updateConstraint()
        }
    }
    
    @objc public dynamic var anchorImageSize: CGFloat = 22.0 {
        didSet {
            updateConstraint()
        }
    }
    
    @objc public dynamic var anchorTextAlignment: NSTextAlignment = .left {
        willSet {
            labelValue.textAlignment = newValue
        }
    }
    
    internal var clickAction : AnchorTapAction?
    
    //MARK: - private
    private let labelValue = UILabel()
    private let ivAccessory = UIImageView()
    private var hLayoutConstraint: [NSLayoutConstraint]?
    private var vLayoutConstraint: [NSLayoutConstraint]?

}

//MARK: - UI
extension NestedSpinnerAnchorView {
    
    private func setup() {
        backgroundColor = .clear
        addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(tapAnchorView(_:))))
        isUserInteractionEnabled = true
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        ivAccessory.translatesAutoresizingMaskIntoConstraints = false
        let tintableImage = anchorAccessoryImage?.withRenderingMode(.alwaysTemplate)
        ivAccessory.image = tintableImage
        ivAccessory.tintColor = anchorTintColor
        addSubview(labelValue)
        addSubview(ivAccessory)
        updateConstraint()
        labelValue.text = "Select..."
        labelValue.textColor = anchorTintColor
        labelValue.font = anchorTextFont
    }
    
    private func updateConstraint() {
        if hLayoutConstraint != nil {
            removeConstraints(hLayoutConstraint!)
        }
        if vLayoutConstraint != nil {
            removeConstraints(vLayoutConstraint!)
        }
        
        let metric = ["space": anchorPadding, "imageSize": anchorImageSize]
        hLayoutConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-space-[labelValue]-2-[ivAccessory(imageSize)]-space-|", options: NSLayoutConstraint.FormatOptions(), metrics: metric, views: ["labelValue" : labelValue, "ivAccessory" : ivAccessory])
        addConstraints(hLayoutConstraint!)
        vLayoutConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-space-[labelValue]-space-|", options: NSLayoutConstraint.FormatOptions(), metrics: metric, views: ["labelValue" : labelValue])
        addConstraints(vLayoutConstraint!)
        ivAccessory.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivAccessory.heightAnchor.constraint(equalTo: ivAccessory.widthAnchor, multiplier: 1.0).isActive = true
        setNeedsUpdateConstraints()
    }
    
    @objc private func tapAnchorView(_ sender: UITapGestureRecognizer) {
        willClickAction?()
        clickAction?()
        didClickAction?()
    }
}
