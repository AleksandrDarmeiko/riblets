//
//  TripsService.swift
//  Riblets Trip
//
//  Created by Alexander on 27/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit




class TripsService {
    
    enum MyTrip {
        case none
        case some([Trip])
    }

    class LoadMyTrips: ServiceOperation<MyTrip> {
        
        var myTrips = [Trip(train: Train(name: "Sprinter",
                                         number: "A1F",
                                         route: Route(departure: "Moscow",
                                                      arrival: "Erevan"),
                                         shcedule: Shcedule(departure: Date(),
                                                            arrival: Date())))]
        
        override init() {
            super.init()
            closure = {
                Thread.sleep(forTimeInterval: 1.5)
                $0 << .success(.some(self.myTrips))
            }
        }
        
    }

    class SearchTripsOperation: ServiceOperation<[Trip]> {
        
        var route: Route?
        
        override init() {
            super.init()
            closure = {
                guard let route = self.route else {
                    $0 << .error(0, "Route is empty")
                    return
                }
                
                Thread.sleep(forTimeInterval: 2.0)
                
                $0 << .success([
                    
                    Trip(train: Train(name: "Sprinter",
                                      number: "A1F",
                                      route: route,
                                      shcedule: Shcedule(departure: Date(),
                                                         arrival: Date()))),
                    
                    Trip(train: Train(name: "Sprinter",
                                      number: "A1F",
                                      route: route,
                                      shcedule: Shcedule(departure: Date(),
                                                         arrival: Date()))),

                    ])
            }
            
        }

    }
    
    var loadMyTrips = LoadMyTrips()
    let searchTrips = SearchTripsOperation()
    
    
}
