//
//  RouteSelectionInteractor.swift
//  Riblets Trip
//
//  Created by Alexander on 25/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit

enum RouteSelectionUserAction {
    case getATrip
    case showLastTrips
    case showCurrentTrip
}

class RouteSelectionInteractor : ViewableInteractor<RouteSelectionRoutable, RouteSelectionUserAction, RouteSelectionPresenter> {
    
    var tripsService: TripsService!

    override func didActivated() {
        super.didActivated()
        
        // поу молчанию мы не имеем путешествий и отображаем ничего
        presenter.present(hasCurrentTrip: false, hasLastTrips: false)
        loadingMyTrips()
    }

    override func didDeactivated() {
        super.didDeactivated()
        
    }
    
    override func handleUserAction(_ action: RouteSelectionUserAction) {
        super.handleUserAction(action)
        presenter.present(userAction: action)
        
        switch action {
        case .getATrip:
            break
            
        case .showCurrentTrip:
            // todo attach current riblet
            
            break
            
        case .showLastTrips:
            // todo attach last riblet
            
            break
        }
    }
 
    private func loadingMyTrips() {
        tripsService.loadMyTrips.stream.listen(owner: self) {
            switch $0 {
            case .success(let result):
                switch result {
                case .none:
                    self.presenter.present(hasCurrentTrip: false, hasLastTrips: false)
                case .some(let trips):
                    self.handle(trips: trips)
                }
            default:
                break
            }
        }
        
        tripsService.loadMyTrips.perform()
    }
    
    private func handle(trips:[Trip]) {
        presenter.present(hasCurrentTrip: hasCurrentTrip(in: trips),
                          hasLastTrips: hasLastTrips(in: trips))
        
        switch (hasCurrentTrip(in: trips), hasLastTrips(in: trips))  {
        case (true, false), (true, true):
            // todo attach currentTripRiblet
            break
            
        case (false, true):
            // todo attach lastTripRiblet
            break
    
        default:
            break
        }

    }
    
    private func hasCurrentTrip(in trips:[Trip]) -> Bool {
        return true
    }
    
    private func hasLastTrips(in trips:[Trip]) -> Bool {
        return true
    }

}
