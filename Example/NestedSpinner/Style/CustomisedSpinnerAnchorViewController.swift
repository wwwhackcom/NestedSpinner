//
//  CustomisedSpinnerAnchorViewController.swift
//  NestedSpinner
//
//  Created by Nick on 22/09/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit
import NestedSpinner

class CustomisedSpinnerAnchorViewController: UIViewController {
    
    @IBOutlet weak var spinner: NestedSpinnerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Customised Anchor View"
        setup()
    }
    
    func setup() {
        let color = UIColor(red: 38.0/255.0, green: 156.0/255.0, blue: 187.0/255.0, alpha: 1)
        spinner.style.popBackgroundColor = color
        spinner.style.tableViewBackgroundColor = color
        spinner.style.cellBackgroundColor = color
        spinner.style.cellSelectedBackgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.3)
        spinner.style.cellTextColor = .white
        spinner.style.cellSelectedTextColor = .white
        spinner.style.cellTextAlignment = .left
        spinner.dataSource = [Entity("Accessory Image", 1), Entity("No Accessory", 2), Entity("Tint Color", 3), Entity("Padding", 4), Entity("Allignment", 5), Entity("Text Font", 6), Entity("Popup Offset", 7), Entity("Appearance", 8)]
        self.spinner.anchorOffset = CGPoint(x: 0, y: self.spinner.bounds.size.height)
        spinner.selectionAction = { indexPath, value, userdata in
            if userdata is Entity {
                let entity = userdata as! Entity
                switch entity.data {
                    
                case 1:
                    if #available(iOS 13.0, *) {
                        self.spinner.anchorImageSize = 28.0
                        self.spinner.anchorAccessoryImage = UIImage(systemName: "arrow.down.heart.fill")
                    }
                    break
                    
                case 2:
                    if #available(iOS 13.0, *) {
                        self.spinner.anchorImageSize = 0
                    }
                    break
                    
                case 3:
                    self.spinner.anchorTintColor = UIColor(red: 38.0/255.0, green: 156.0/255.0, blue: 187.0/255.0, alpha: 1)
                    break
                    
                case 4:
                    self.spinner.anchorPadding = 20.0
                    break
                    
                case 5:
                    self.spinner.anchorTextAlignment = .center
                    break
                    
                case 6:
                    self.spinner.anchorTextFont = UIFont.italicSystemFont(ofSize: 20)
                    break
                    
                case 7:
                    self.spinner.anchorOffset = CGPoint(x: 0, y: self.spinner.bounds.size.height + 30)
                    break
                    
                case 8:
                    self.spinner.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
                    self.spinner.layer.cornerRadius = 5.0
                    self.spinner.layer.borderColor = UIColor(white: 0.7, alpha: 0.7).cgColor
                    self.spinner.layer.borderWidth = 2.0
                    self.spinner.layer.shadowColor = UIColor.black.cgColor
                    self.spinner.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
                    self.spinner.layer.shadowOpacity = 0.6
                    self.spinner.layer.shadowRadius = 5.0
                    break
                    
                default:
                   break
                }
            }
        }
    }
    
}
