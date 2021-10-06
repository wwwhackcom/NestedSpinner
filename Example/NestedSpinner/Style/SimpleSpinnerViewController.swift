//
//  SimpleSpinnerViewController.swift
//  NestedSpinner
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit
import NestedSpinner

class SimpleSpinnerViewController: UIViewController {
    
    var spinner: NestedSpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Simple Spinner"
        setup("Dark Style")
    }
    
    func setup(_ style: String) {
        setStyle(style)
        spinner = NestedSpinnerView(frame: CGRect(x: 50, y: 160, width: self.view.bounds.width - 100, height: 50))
        spinner.anchorTextFont = UIFont.boldSystemFont(ofSize: 18)
        spinner.anchorTintColor = .darkText
        spinner.dataSource = [Entity("Light Style"), Entity("Dark Style"), Entity("Customised Globally"), Entity("Customised Attributes", 1), Entity("Customised AnchorView", 2)]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.selectionAction = { indexPath, value, userdata in
            if userdata is Entity {
                let entity = userdata as! Entity
                if entity.data == nil {
                    self.spinner.removeFromSuperview()
                    self.setup(entity.name)
                    self.spinner.anchorValue = entity.name
                } else {
                    switch entity.data {
                    case 1:
                        self.performSegue(withIdentifier: "identifierCustomisedSimpleSpinner", sender: nil)
                        break
                    case 2:
                        self.performSegue(withIdentifier: "identifierCustomisedAnchorSpinner", sender: nil)
                        break
                    default:
                        break
                    }
                }
            }
        }
        self.view.addSubview(spinner)
    }
    
    func setStyle(_ style: String) {
        switch style {
        case "Light Style":
            NestedSpinnerAppearance.light()
            break
        case "Dark Style":
            NestedSpinnerAppearance.dark()
            break
        case "Customised Globally":
            NestedSpinnerAppearance.customisedStyle()
            break
        default:
            break
        }
    }
    
}
