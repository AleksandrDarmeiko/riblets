//
//  ViewableBuilder.swift
//  RibletsKit
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
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
