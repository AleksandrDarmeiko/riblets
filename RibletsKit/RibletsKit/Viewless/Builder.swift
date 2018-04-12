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

