//
//  Copyright (c) 2018. Aleksandr Darmeiko
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


import Foundation

public protocol Routable : class {
    
    init()
    func activate()
    func deactivate()
    var name: String! { get set }
    var children: [Routable] { get set }
    var parent: Routable? { get set }
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
