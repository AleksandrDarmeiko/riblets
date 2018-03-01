//
//  Router.swift
//  RibletsKit
//
//  Created by Alexander on 01/10/2017.
//  Copyright © 2017 Alexander Brin. All rights reserved.
//

import Foundation

public protocol Routable : class {
    
    init()
    func activate()
    func deactivate()
    var name: String! { get set }
    var children: [Routable] { get set }
    weak var parent: Routable? { get set }
}

open class Router<InteractorClass> : Routable where InteractorClass : Interactable {
    
    public var name : String!
    public var interactor: InteractorClass!
    
    var isActive = false
    
    required public init() {}
    
    public func activate() {
        isActive = true
        interactor.activate()
    }

    public func deactivate() {
        isActive = false
        interactor.deactivate()
        deactivateSubtree()
    }
    
    private func deactivateSubtree() {
        for (_, child) in children.enumerated() {
            child.deactivate()
        }
    }
    
    public var children = [Routable]()
    public weak var parent: Routable?
    
    public func attachChild(router child: Routable) {
        children.append(child)
        child.parent = self
        child.activate()
    }
    
    public func removeChild(router child: Routable) {
        children.remove(at: index(of: child))
        child.parent = nil
        child.deactivate()
    }
    
    private func index(of child: Routable) -> Int {
        for (index, someChild) in children.enumerated() {
            if child === someChild {
                return index
            }
        }
        
        return -1
    }
    
}
