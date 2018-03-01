//
//  Builder.swift
//  RibletsKit
//
//  Created by Alexander on 11/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation

/*
public class PrimaryUnitsFactory<RouterClass, InteractorClass>
    where InteractorClass: InteractableDependencies,
    RouterClass: Router<InteractorClass>
{
    
    let routerClass : RouterClass.Type
    let interactorClass : InteractorClass.Type
    
    public init(routerClass : RouterClass.Type,
         interactorClass : InteractorClass.Type) {
        self.routerClass = routerClass
        self.interactorClass = interactorClass
    }
    
    func factoryRouter() -> RouterClass {
        let router = routerClass.init()
        router.name = String(describing: routerClass)
        return router
    }
    
    func factoryInteractor() -> InteractorClass {
        return interactorClass.init()
    }
    
    public func buildPrimaryUnits() -> RouterClass {
        // instantiates all primary Riblet units
        let router = factoryRouter()
        let interactor = factoryInteractor()
        
        // Defines primary dependencies
        router.interactor = interactor
        interactor.router = router as! InteractorClass.RouterProtocol
        
        // returns Riblets entry point
        return router
    }
    
}*/

open class Builder<ComponentClass, RouterClass, InteractorClass> where InteractorClass: InteractableDependencies,
                                                                           RouterClass: Router<InteractorClass> {

    public let component: ComponentClass
    
    let routerClass : RouterClass.Type
    let interactorClass : InteractorClass.Type
    
    public init(_ component: ComponentClass,
                routerClass: RouterClass.Type,
                interactorClass: InteractorClass.Type) {
        self.component = component
        self.routerClass = routerClass
        self.interactorClass = interactorClass
    }
    
    func factoryRouter() -> RouterClass {
        let router = routerClass.init()
        router.name = String(describing: routerClass)
        return router
    }
    
    func factoryInteractor() -> InteractorClass {
        return interactorClass.init()
    }
    
    public func buildPrimaryUnits() -> RouterClass {
        // instantiates all primary Riblet units
        let router = factoryRouter()
        let interactor = factoryInteractor()
        
        definePrimareDpendencies(router: router, interactor: interactor)
        
        // returns Riblets entry point
        return router
    }
    
    func definePrimareDpendencies(router: RouterClass, interactor: InteractorClass) {
        // Defines primary dependencies
        router.interactor = interactor
        interactor.router = router as! InteractorClass.RouterProtocol
    }
    
    /*public init(_ component: ComponentClass, factory: PrimaryUnitsFactory<RouterClass, InteractorClass>) {
        self.component = component
        self.factory = factory
    }*/

}

