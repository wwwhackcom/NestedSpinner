//
//  SimpleSinnerCellViewController.swift
//  NestedSpinner
//
//  Created by Nick Wang on 9/10/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit
import NestedSpinner

class SimpleSinnerCellViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customised Cell"
        setup()
    }
    
    func setup() {
        NestedSpinnerAppearance.light()
        let spinner = NestedSpinnerView(frame: CGRect(x: 50, y: 120, width: self.view.bounds.width - 100, height: 50))
        spinner.anchorValue = "Select Language"
        spinner.dataSource = [Entity("", 0), Entity("", 1), Entity("", 2), Entity("", 3), Entity("", 4)]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.cellConfiguration = { index, value in
            
            switch index {
            case 0:
                return "简体中文"
            case 1:
                return "English"
            case 2:
                return "Español"
            case 3:
                return "Português"
            case 4:
                return "Français"
            default:
                return ""
            }
            
        }
        spinner.customisedCellConfiguration = { index, value, userdata, cell in
            
        }
        self.view.addSubview(spinner)
    }
    
}
