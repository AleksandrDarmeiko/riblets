//
//  CoordinatorInteractor.swift
//  Riblets Trip
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation
import RibletsKit


class CoordinatorInteractor: Interactor<CoordinatorRoutable> {

    override func didActivated() {
        super.didActivated()
        
        router.attachRouteSelection()
        
        
    }
}
