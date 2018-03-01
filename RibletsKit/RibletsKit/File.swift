//
//  File.swift
//  RibletsKit
//
//  Created by Alexander on 29/09/2017.
//  Copyright © 2017 Alexander Brin. All rights reserved.
//

import Foundation






// хранит состояние данных после отработки логики
//
//
//












//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE
//  EXAMPLE




/*
// Может лучше сделать UserActions
enum RouteSelectionViewEvent {
    
    case buyTicket(String)
    
}

class RouteSelectionView : View<RouteSelectionViewEvent> {
    
    var cityLabel : UILabel!
    
    // Содержит контролы и лейблы
    
    func didTapButton() {
        eventsStream.send(.buyTicket("wow!"))
    }
}

class RouteSelectionPresenter : Presenter<RouteSelectionView> {
    
    func display(city : String) {
        view.cityLabel.text = city.capitalized
    }

}

class RouteSelectionInteractor: Interactor<RouteSelectionPresenter, RouteSelectionViewEvent, RouteSelectionRouter> {
    
    var selectedRouteId : Int!
    
    override func didActivated() {
        super.didActivated()
        let city = "City" // loading from settings
        presenter.display(city: city)
        
        
    }

    override func handleAction(_ action: RouteSelectionViewEvent) {
        super.handleAction(action)
        
        switch action {
            
        case .buyTicket(let emoji):
            print(emoji)
            // service.buyTicket(selectedRouteId)
            router.attachTrainList()
            break
            
        }
        
    }
    
    override func didDeactivated() {
        super.didDeactivated()
        
        
    }
    
}

class RouteSelectionRouter : Router<RouteSelectionView> {
    
    func attachTrainList() {
        
    }
    
}
*/

