//
//  RouteSelectionRouter.swift
//  Riblets Trip
//
//  Created by Alexander on 25/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit

/*!
 @brief
 
 @discussion
 public methods for Interactor
 */
protocol RouteSelectionRoutable : ViewableRoutable {
    
}

/*!
 @brief
 
 @discussion
 - Helper methods for attaching and detaching Routers
 - State-switching logic for determining states between multiple children
 */
class RouteSelectionRouter: ViewableRouter<RouteSelectionInteractor, RouteSelectionViewController>, RouteSelectionRoutable  {
    
}


