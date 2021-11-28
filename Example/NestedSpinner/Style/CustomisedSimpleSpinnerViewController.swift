//
//  CustomisedSimpleSpinnerViewController.swift
//  NestedSpinner
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit
import NestedSpinner

class CustomisedSimpleSpinnerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customised Simple Spinner"
        setup1()
        setup2()
    }
    
    func setup1() {
        let color = UIColor(red: 38.0/255.0, green: 156.0/255.0, blue: 187.0/255.0, alpha: 1)
        let spinner = NestedSpinnerView(frame: CGRect(x: 50, y: 120, width: self.view.bounds.width - 100, height: 50))
        spinner.anchorTintColor = color
        spinner.style.popBackgroundColor = color
        spinner.style.tableViewBackgroundColor = color
        spinner.style.cellBackgroundColor = color
        spinner.style.cellSelectedBackgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.3)
        spinner.style.cellTextColor = .white
        spinner.style.cellSelectedTextColor = .white
        spinner.style.cellTextAlignment = .left
        spinner.anchorTextFont = UIFont.boldSystemFont(ofSize: 18)
        spinner.anchorValue = "Select Language"
        spinner.dataSource = [Entity(""), Entity("简体中文", UIImage(named: "chinese")), Entity("English", UIImage(named: "english")), Entity("Español", UIImage(named: "spanish")), Entity("Português", UIImage(named: "portuguese")), Entity("Français", UIImage(named: "french"))]
        
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        spinner.selectionAction = { indexPath, value, userdata in
            if userdata is Entity {
                let entity = userdata as! Entity
                if entity.name.count == 0 {
                    spinner.anchorValue = "Select Language"
                }
            }
        }
        self.view.addSubview(spinner)
    }
    
    func setup2() {
        let color = UIColor(red: 92.0/255.0, green: 171.0/255.0, blue: 0, alpha: 1)
        let spinner = NestedSpinnerView(frame: CGRect(x: 50, y: 240, width: self.view.bounds.width - 100, height: 50))
        spinner.style.popBackgroundColor = color
        spinner.anchorTintColor = color
        spinner.style.tableViewBackgroundColor = color
        spinner.style.cellBackgroundColor = color
        spinner.style.cellSelectedBackgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.2)
        spinner.style.cellTextColor = .white
        spinner.style.cellSelectedTextColor = .white
        spinner.anchorTextFont = UIFont.boldSystemFont(ofSize: 16)
        spinner.anchorValue = "Select Language"
        spinner.dataSource = [Entity("Swift"), Entity("Objc"), Entity("Kotlin"), Entity("Java"), Entity("TypeScript"), Entity("Go"), Entity("C#"), Entity("Python"), Entity("PHP")]
        spinner.anchorOffset = CGPoint(x: 0, y: spinner.bounds.size.height)
        self.view.addSubview(spinner)
    }
    
}
