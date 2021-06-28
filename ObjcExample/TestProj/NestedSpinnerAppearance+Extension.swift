//
//  NestedSpinnerAppearance+Extension.swift
//  TestProj
//
//  Created by Nick Wang on 28/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import Foundation
import NestedSpinner

//MARK: - Customised style
extension NestedSpinnerAppearance {
    
    static func customisedStyle() {
        darkNested()
        globalStyle.selectionBackgroundColor = UIColor(white: 0.3, alpha: 0.2)
    }
    
}
