//
//  ViewController.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit
import NestedSpinner

class ViewController: UIViewController {
    
    @IBOutlet weak var spinner: NestedSpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNestedSpinner()
    }

    func setup() {
        spinner.anchorTextFont = UIFont.boldSystemFont(ofSize: 18)
        spinner.anchorTintColor = .darkText
        spinner.dataSource = [Entity(""), Entity("Normal Spinner"), Entity("Nested Spinner")]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.selectionAction = { index, value, userdata in
            if value.count == 0 {
                self.spinner.anchorValue = "Please Select..."
            }
        }
    }

    func setupNestedSpinner() {
        spinner.anchorTextFont = UIFont.boldSystemFont(ofSize: 18)
        spinner.anchorTintColor = .darkText
        
        let groupItem1 = NestedSpinnerItem("Normal Spinner", [Entity("Style 1"), Entity("Style 2"), Entity("Style 3")])
        let groupItem2 = NestedSpinnerItem("Nested Spinner", [Entity("Style 1"), Entity("Style 2"), Entity("Style 3")])
        spinner.dataTrees = [groupItem1, groupItem2]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.selectionAction = { index, value, userdata in
            print("selected value:\(value)")
        }
    }
    
}
