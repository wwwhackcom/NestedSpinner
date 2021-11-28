//
//  NestedSpinnerDefine.swift
//  NestedSpinner
//
//  Created by Nick on 8/06/21.
//  Copyright © 2021 Nick Wang. All rights reserved.
//

import UIKit

/// Normal Spinner:  The data need to conform to this protocol
@objc public protocol NestedSpinnerDataSource: AnyObject {
    
    func getTitle() -> String
    
    @objc optional func getLeftImage() -> UIImage?
    
}

/// Nested Spinner: Group item class
@objc public class NestedSpinnerItem: NSObject, NestedSpinnerGroupItem {
    
    public var groupItemTitle: String = ""
    public var isCollapsed = false
    public var isCollapsible = true
    public var subItems = NSArray()
    
    public convenience init(_ groupItemTitle: String, _ subItems: NSArray) {
        self.init(groupItemTitle, subItems, false)
    }
    
    public convenience init(_ groupItemTitle: String, _ subItems: NSArray, _ isCollapsed: Bool) {
        self.init()
        self.groupItemTitle = groupItemTitle
        self.subItems = subItems
        self.isCollapsed = isCollapsed
    }
}

/// Nested Spinner: Group item needs to conform to this protocol
@objc public protocol NestedSpinnerGroupItem: AnyObject {
    
    var groupItemTitle: String { get }
    var isCollapsed: Bool { get set }
    var isCollapsible: Bool { get }
    var subItems: NSArray { get }
    
}

/// Nested Spinner: Sub item needs to conform to this protocol
@objc public protocol NestedSpinnerSubItem: AnyObject {
    
    func getSubTitle() -> String
    
    @objc optional func getSubLeftImage() -> UIImage?
    
}


public typealias AppearanceCustomisedClosure = () -> Void
public typealias AnchorTapAction = () -> Void
public typealias CancelAction = () -> Void
public typealias SelectionAction = (IndexPath, String, AnyObject?) -> Void
public typealias ReloadSection = (_ section: Int) -> Void
public typealias ValueConfigurationClosure = (Int, String) -> String
public typealias CellConfigurationClosure = (Int, String, AnyObject?, NestedSpinnerCell) -> Void
public typealias SectionConfigurationClosure = (Int, String, NestedSpinnerGroupItem?, NestedGroupItemCell) -> Void
public typealias ComputeLayoutTuple = (x: CGFloat, y: CGFloat, width: CGFloat, offscreenHeight: CGFloat)

internal protocol InitializableClass: AnyObject {
    init()
}

extension InitializableClass {
    
    init(_ block: (Self) -> Void) {
        self.init()
        block(self)
    }

    @discardableResult func with(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
}

public protocol InitializableStruct {
    init()
}

public extension InitializableStruct {
    
    init(_ block: (inout Self) -> Void) {
        self.init()
        block(&self)
    }

    @discardableResult mutating func with(_ block: (inout Self) -> Void) -> Self {
        block(&self)
        return self
    }
    
}

public extension DispatchQueue {
    static func executeOnMainThread(_ closure: @escaping CancelAction) {
        if Thread.isMainThread {
            closure()
        } else {
            main.async(execute: closure)
        }
    }
}

extension NSLayoutConstraint {
    
    func updateMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
