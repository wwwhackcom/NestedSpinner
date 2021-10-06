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
    
    convenience init(_ name: String) {
        self.init(name, nil, nil, nil)
    }
    
    convenience init(_ name: String, _ data: Int?) {
        self.init(name, data, nil, nil)
    }
    
    init(_ name: String, _ data: Int?, _ backgroundColour: String?, _ textColour: String?) {
        self.name = name
        self.data = data
        self.backgroundColour = backgroundColour
        self.textColour = textColour
    }
    
    func getTitle() -> String {
        return name
    }
    
    func getSubTitle() -> String {
        return name
    }
    
}
