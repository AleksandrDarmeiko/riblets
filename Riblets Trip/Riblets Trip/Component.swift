//
//  Component.swift
//  Riblets Trip
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit

class Component {

    var routeSelectoinBuilder: RouteSelectionBuilder {
        get {
            return RouteSelectionBuilder.defaultBuilder(component: self)
        }
    }
    
    lazy var tripsService: TripsService = {
        return TripsService()
    }()
    
}

