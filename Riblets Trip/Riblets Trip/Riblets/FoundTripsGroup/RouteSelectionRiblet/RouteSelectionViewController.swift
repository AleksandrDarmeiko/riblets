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

class RouteSelectionViewController: ViewController<RouteSelectionUserAction> {
    
    
    
    /*!
     @brief
     
     @discussion
     
     Do any additional setup after loading the view.
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /*!
     @brief
     
     @discussion
     
     Dispose of any resources that can be recreated.
     
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: Public display methods for Presenter
    
    @IBOutlet weak var currentTripButton: UIButton!
    @IBOutlet weak var lastTripButton: UIButton!
    
    func displayShowCurrentTripButton() {
        currentTripButton.isHidden = false
        lastTripButton.isHidden = true
    }
    
    func displayShowLastTripsButton() {
        currentTripButton.isHidden = true
        lastTripButton.isHidden = false
    }
    
    func hideTripsButtons() {
        currentTripButton.isHidden = true
        lastTripButton.isHidden = true
    }
    
    // MARK: Public view hierarchy accessors for Router
    
    @IBOutlet weak var currentTripContainer: UIView!
    
    // MARK: User actions

    @IBAction func getATrip(_ sender: Any) {
        send(action: .getATrip)
    }
    
    @IBAction func showLastTrips(_ sender: Any) {
        send(action: .showLastTrips)
    }
    
    @IBAction func showCurrentTrip(_ sender: Any) {
        send(action: .showCurrentTrip)
    }
    
    
}
