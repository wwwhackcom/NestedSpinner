//
//  NestedSpinnerAppearance+Extension.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import Foundation
import NestedSpinner

//MARK: - Customised style
extension NestedSpinnerAppearance {
    
    static func customisedStyle() {
        //define your customised global style here
        globalStyle.innerPaddingTop = 0
        globalStyle.innerPaddingBottom = 0
        globalStyle.innerPaddingLeft = 0
        globalStyle.innerPaddingRight = 0
        globalStyle.tableViewBackgroundColor = UIColor(red: 38.0/255.0, green: 156.0/255.0, blue: 187.0/255.0, alpha: 1)
        globalStyle.cellTextColor = .white
        globalStyle.cellSelectedTextColor = .lightText
        globalStyle.cellTextAlignment = .left
        globalStyle.cellSelectedBackgroundColor = UIColor(red: 177.0/255.0, green: 200.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    
}
