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
        self.title = "Examples"
        spinner.dataSource = [Entity("Simple Spinner"), Entity("Nested Spinner")]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.selectionAction = { indexPath, value, userdata in
            if userdata is Entity {
                let entity = userdata as! Entity
                switch entity.name {
                case "Simple Spinner":
                    self.performSegue(withIdentifier: "identifierSimpleSpinner", sender: nil)
                    break
                case "Nested Spinner":
                    self.performSegue(withIdentifier: "identifierNestedSpinner", sender: nil)
                    break
                default:
                    break
                }
            }
        }
    }
    
}
