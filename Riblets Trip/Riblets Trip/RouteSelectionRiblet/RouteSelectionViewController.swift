//
//  RoutePickerRiblet.swift
//  Riblets Trip
//
//  Created by Alexander on 16/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
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
