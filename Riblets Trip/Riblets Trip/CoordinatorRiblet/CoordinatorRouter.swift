//
//  CoordinatorRouter.swift
//  Riblets Trip
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit

protocol CoordinatorRoutable : Routable {
    
    func attachRouteSelection()
    
}

class CoordinatorRouter: Router<CoordinatorInteractor>, CoordinatorRoutable {

    var routeSelectoinBuilder: RouteSelectionBuilder!
    var routeSelectoinRouter: ViewableRoutable!
    
    var window: UIWindow?
    
    
    func attachRouteSelection() {

        if let _ = window {
            
        }
        else {
            window = UIWindow(frame: UIScreen.main.bounds)
            window!.makeKeyAndVisible()
        }
        
        routeSelectoinRouter = routeSelectoinBuilder.buid()
        attachChild(router: routeSelectoinRouter)
        
        let navigationController = UINavigationController()
        navigationController.pushViewController(routeSelectoinRouter.baseViewController, animated: false)
        window?.rootViewController = navigationController
        
    }
    
    
}

