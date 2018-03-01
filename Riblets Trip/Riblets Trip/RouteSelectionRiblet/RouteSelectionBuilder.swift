//
//  RouteSelectionBuilder.swift
//  Riblets Trip
//
//  Created by Alexander on 25/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit

class RouteSelectionBuilder: ViewableBuilder<Component,
                                             RouteSelectionRouter,
                                             RouteSelectionInteractor,
                                             RouteSelectionPresenter,
                                             RouteSelectionViewController> {
    
    static func defaultBuilder(component: Component) -> RouteSelectionBuilder {
        return RouteSelectionBuilder(component,
                                     routerClass: RouteSelectionRouter.self,
                                     interactorClass: RouteSelectionInteractor.self,
                                     presenterClass: RouteSelectionPresenter.self,
                                     viewControllerClass: RouteSelectionViewController.self)
    }
    
    /*!
     @brief
     
     @discussion
     - Defines secondary dependencies
     - Define communication dependencies
     */
    func buid() -> ViewableRoutable {
        let router = buildPrimaryUnits()
        
        router.interactor.tripsService = component.tripsService
        
        return router
    }
    
}
