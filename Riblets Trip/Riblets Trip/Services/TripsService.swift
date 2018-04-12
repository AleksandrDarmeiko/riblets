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
