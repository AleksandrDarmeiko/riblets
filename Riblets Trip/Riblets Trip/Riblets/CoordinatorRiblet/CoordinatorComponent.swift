//
//  CoordinatorComponent.swift
//  Riblets Trip
//
//  Created by Alexander on 19/03/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation

class CoordinatorComponent {
    
    var routeSelectoinBuilder: RouteSelectionBuilder {
        get {
            return RouteSelectionBuilder.defaultBuilder(component: RouteSelectionComponent())
        }
    }
    
}
