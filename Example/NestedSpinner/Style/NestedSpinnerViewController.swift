//
//  NestedSpinnerViewController.swift
//  NestedSpinner
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit
import NestedSpinner

class NestedSpinnerViewController: UIViewController {
    
    var spinner: NestedSpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nested Spinner"
        setup()
    }
    
    func setup() {
        NestedSpinnerAppearance.darkNested()
        spinner = NestedSpinnerView(frame: CGRect(x: 50, y: 160, width: self.view.bounds.width - 100, height: 50))
        spinner.style.cellSelectedBackgroundColor = UIColor(white: 0.3, alpha: 0.2)
        spinner.anchorTextFont = UIFont.boldSystemFont(ofSize: 18)
        spinner.anchorTintColor = .darkText
        spinner.cellNib = UINib(nibName: String(describing: NestedSubItemCell.self), bundle: NestedSpinnerBundle.bundle)
        let groupItem1 = NestedSpinnerItem("Basic Usage", [Entity("Normal Spinner", 1), Entity("Nested Spinner", 2), Entity("Programmatically", 3)])//"Init Expanded, Colours"
        let groupItem2 = NestedSpinnerItem("Customised", [Entity("Custom Attributes", 4), Entity("Delegate Colours", 5), Entity("Custom AnchorView", 6)])
        spinner.dataTrees = [groupItem1, groupItem2]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.selectionAction = { indexPath, value, userdata in
            print("indexPath: \(indexPath), selected value:\(value)")
            if userdata is Entity {
                let entity = userdata as! Entity
                switch entity.data {
                case 1:
                    break
                default:
                    break
                }
                
            }
        }
        self.view.addSubview(spinner)
    }
    
}
