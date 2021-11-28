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
    var data: NSNumber?
    var backgroundColour: String?
    var textColour: String?
    var image: UIImage?
    
    convenience init(_ name: String) {
        self.init(withName: name, withData: nil, withBackgroundColour: nil, withTextColour: nil, withImage: nil)
    }
    
    convenience init(withName name: String, withData data: NSNumber?) {
        self.init(withName: name, withData: data, withBackgroundColour: nil, withTextColour: nil, withImage: nil)
    }
    
    convenience init(withName name: String, withImage image: UIImage?) {
        self.init(withName: name, withData: nil, withBackgroundColour: nil, withTextColour: nil, withImage: image)
    }
    
    init(withName name: String, withData data: NSNumber?, withBackgroundColour backgroundColour: String?, withTextColour textColour: String?, withImage image: UIImage?) {
        self.name = name
        self.data = data
        self.backgroundColour = backgroundColour
        self.textColour = textColour
        self.image = image
    }
    
    public func getTitle() -> String {
        return name
    }
    
    public func getSubTitle() -> String {
        return name
    }
    
    public func getLeftImage() -> UIImage? {
        return image
    }
    
}
