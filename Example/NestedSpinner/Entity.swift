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
    var data: AnyObject?
    
    init(_ name: String) {
        self.name = name
    }
    
    func getTitle() -> String {
        return name
    }
    
    func getSubTitle() -> String {
        return name
    }
    
}
