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

open class ViewableBuilder<ComponentClass, RouterClass, InteractorClass, PresenterClass, ViewControllerClass>:
    Builder<ComponentClass, RouterClass, InteractorClass>
        where InteractorClass: ViewableInteractableDependencies,
                  RouterClass: ViewableRouter<InteractorClass, ViewControllerClass>,
               PresenterClass: Presenter<ViewControllerClass> {
 
    let presenterClass: PresenterClass.Type
    let viewControllerClass: ViewControllerClass.Type
    
    public init(_ component: ComponentClass,
                routerClass: RouterClass.Type,
                interactorClass: InteractorClass.Type,
                presenterClass: PresenterClass.Type,
                viewControllerClass: ViewControllerClass.Type) {
        self.presenterClass = presenterClass
        self.viewControllerClass = viewControllerClass
        super.init(component, routerClass: routerClass, interactorClass: interactorClass)
    }
    
    override public func buildPrimaryUnits() -> RouterClass {
        let router = super.buildPrimaryUnits()
        
        // instantiates all primary Riblet units
        let presenter = factoryPresenter()
        let viewController = UIStoryboard.factoryRibletViewController(reflecting: viewControllerClass)
        
        // Defines primary dependencies
        router.interactor.presenter = presenter as! InteractorClass.PresenterClass
        router.viewController = viewController
        presenter.view = viewController
        viewController.userActionsStream = (router.interactor.userActionsStream as! ModelStream<Optional<ViewControllerClass.ActionType>>)

        return router
    }
    
    func factoryPresenter() -> PresenterClass {
        return presenterClass.init()
    }
    
    
    
}
