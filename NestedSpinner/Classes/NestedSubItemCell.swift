//
//  NestedSubItemCell.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

open class NestedSubItemCell : NestedSpinnerCell {
    
    @IBOutlet public weak var bgView: UIView!
    @IBOutlet weak var bgViewPaddingTop: NSLayoutConstraint!
    @IBOutlet weak var bgViewPaddingBottom: NSLayoutConstraint!
}

//MARK: - UI
extension NestedSubItemCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
