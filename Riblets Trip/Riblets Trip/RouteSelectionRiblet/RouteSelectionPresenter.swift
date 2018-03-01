//
//  RouteSelectionPresenter.swift
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
 - Do any view logic here. Any if-else construction must be declared here
 - public methods for Interactor. Methods present Model structs provided by Interactor into ViewController
 display methods calls with prepared for viewing data. Name of any method for this purpose must be started with "present".
 */
class RouteSelectionPresenter: Presenter<RouteSelectionViewController> {
    
    func present(userAction: RouteSelectionUserAction) {
        switch userAction {
        case .showCurrentTrip:
            view.displayShowLastTripsButton()
        case .showLastTrips:
            view.displayShowCurrentTripButton()
            
        default:
            break
        }
        
    }
 
    // обновляет возможности вида (кнопки)
    func present(hasCurrentTrip: Bool,
                 hasLastTrips: Bool) {
        
        switch (hasCurrentTrip, hasLastTrips)  {
        case (true, false):
            // Если есть только полько текущая поездка то кнопки отображать не надо
            view.hideTripsButtons()

        case (true, true):
            view.displayShowLastTripsButton()
            
        case (false, true), (false, false):
            // Если есть только прошлые поездки и нет текущих то кнопки отображать не надо
            view.hideTripsButtons()

            
       
        }
        
        
    }
    
    
    
    
}

