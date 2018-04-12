//
//  Copyright (c) 2018. Aleksandr Darmeiko
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
