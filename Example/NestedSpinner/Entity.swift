//
//  Entity.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import Foundation
import NestedSpinner

class Entity: NestedSpinnerDataSource, NestedSpinnerSubItem {
    
    var name: String!
    var data: Int?
    var backgroundColour: String?
    var textColour: String?
    var image: UIImage?
    
    convenience init(_ name: String) {
        self.init(name, nil, nil, nil, nil)
    }
    
    convenience init(_ name: String, _ image: UIImage?) {
        self.init(name, nil, nil, nil, image)
    }
    
    convenience init(_ name: String, _ data: Int?) {
        self.init(name, data, nil, nil, nil)
    }
    
    init(_ name: String, _ data: Int?, _ backgroundColour: String?, _ textColour: String?, _ image: UIImage?) {
        self.name = name
        self.data = data
        self.backgroundColour = backgroundColour
        self.textColour = textColour
        self.image = image
    }
    
    func getTitle() -> String {
        return name
    }
    
    func getSubTitle() -> String {
        return name
    }
    
    func getLeftImage() -> UIImage? {
        return image
    }
    
}
