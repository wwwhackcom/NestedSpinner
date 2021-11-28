//
//  NestedSpinnerCell.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

@objc(NestedSpinnerCell)
open class NestedSpinnerCell: UITableViewCell {
        
    @IBOutlet open weak var labelTitle: UILabel!
    @IBOutlet open weak var ivLeft: UIImageView!
    @IBOutlet open weak var ivLeftAspectRatio: NSLayoutConstraint!
    
    var selectedBackgroundColor: UIColor?
    var highlightTextColor: UIColor?
    var normalTextColor: UIColor?

}

//MARK: - UI
extension NestedSpinnerCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    override open var isSelected: Bool {
        willSet {
            setSelected(newValue, animated: false)
        }
    }
    
    override open var isHighlighted: Bool {
        willSet {
            setSelected(newValue, animated: false)
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setSelected(highlighted, animated: animated)
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        let executeSelection: () -> Void = { [weak self] in
            guard let `self` = self else { return }

            if let selectedBackgroundColor = self.selectedBackgroundColor {
                if selected {
                    self.backgroundColor = selectedBackgroundColor
                    self.labelTitle.textColor = self.highlightTextColor
                } else {
                    self.backgroundColor = .clear
                    self.labelTitle.textColor = self.normalTextColor
                }
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                executeSelection()
            })
        } else {
            executeSelection()
        }

        accessibilityTraits = selected ? UIAccessibilityTraits.selected : UIAccessibilityTraits.none }
    
}
