//
//  CoordinatorBuilder.swift
//  Riblets Trip
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit

class CoordinatorBuilder: Builder<CoordinatorComponent, CoordinatorRouter, CoordinatorInteractor> {
    
    static func defaultBuilder(component: CoordinatorComponent) -> CoordinatorBuilder {
        return CoordinatorBuilder(component,
                                  routerClass : CoordinatorRouter.self,
                                  interactorClass : CoordinatorInteractor.self)
    }
    
    func buid() -> Routable {
        let router = buildPrimaryUnits()
        
        router.routeSelectoinBuilder = component.routeSelectoinBuilder
        
        return router
    }
    
    
}



