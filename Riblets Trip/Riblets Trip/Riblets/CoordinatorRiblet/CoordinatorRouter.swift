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

