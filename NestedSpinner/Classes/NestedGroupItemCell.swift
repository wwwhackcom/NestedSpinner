//
//  NestedGroupItemCell.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

protocol NestedGroupItemCellDelegate: AnyObject {
    func toggleSection(header: NestedGroupItemCell, section: Int)
}

@objc(NestedGroupItemCell)
open class NestedGroupItemCell: UITableViewHeaderFooterView {
    
    
    @IBOutlet public weak var bgView: UIView!
    @IBOutlet public weak var labelTitle: UILabel!
    @IBOutlet public weak var ivArrow: UIImageView!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bgViewPaddingTop: NSLayoutConstraint!
    
    var section: Int = 0
    var groupItem: NestedSpinnerGroupItem? {
        didSet {
            guard let item = groupItem else {
                return
            }
            
            labelTitle.text = item.groupItemTitle
            ivArrow.isHidden = false
            ivArrow.image = item.isCollapsed ? NestedSpinnerConstants.PopupView.Image.Right : NestedSpinnerConstants.PopupView.Image.Down
        }
    }
    weak var delegate: NestedGroupItemCellDelegate?
    
}

//MARK: - UI
extension NestedGroupItemCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCollapsed(collapsed: Bool) {
        ivArrow?.rotate(collapsed ? -.pi/2 : 0)
    }
}

extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
}
