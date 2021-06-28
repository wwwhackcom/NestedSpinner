//
//  Entity.swift
//  TestProj
//
//  Created by Nick Wang on 28/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import Foundation
import NestedSpinner

@objcMembers
public class Entity: NSObject, NestedSpinnerDataSource, NestedSpinnerSubItem {
    
    var name: String!
    var data: AnyObject?
    
    public init(_ name: String) {
        self.name = name
    }
    
    public func getTitle() -> String {
        return name
    }
    
    public func getSubTitle() -> String {
        return name
    }
    
}
