//
//  PresentableViewBuilder.swift
//  RibletsKit
//
//  Created by Alexander on 27/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation

open class PresentableViewableBuilder<ComponentClass, RouterClass, InteractorClass, ViewControllerClass>:
    Builder<ComponentClass, RouterClass, InteractorClass>
    where InteractorClass: ViewableInteractableDependencies,
    RouterClass: ViewableRouter<InteractorClass, ViewControllerClass>,
    ViewControllerClass: View {
    
    let viewControllerClass: ViewControllerClass.Type
    
    public init(_ component: ComponentClass,
                routerClass: RouterClass.Type,
                interactorClass: InteractorClass.Type,
                viewControllerClass: ViewControllerClass.Type) {
        self.viewControllerClass = viewControllerClass
        super.init(component, routerClass: routerClass, interactorClass: interactorClass)
    }
    
    override public func buildPrimaryUnits() -> RouterClass {
        let router = super.buildPrimaryUnits()
        
        // instantiates all primary Riblet units
        let viewController = UIStoryboard.factoryRibletViewController(reflecting: viewControllerClass)
        
        // Defines primary dependencies
        router.interactor.presenter = viewController as! InteractorClass.PresenterClass
        router.viewController = viewController
        
        viewController.userActionsStream = (router.interactor.userActionsStream as! ModelStream<Optional<ViewControllerClass.ActionType>>)
        
        return router
    }
    
   
    
}
