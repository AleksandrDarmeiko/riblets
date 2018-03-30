//
//  NavigationController.swift
//  RibletsKit
//
//  Created by Alexander on 04/03/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation


open class NavigationController<ActionType> : UINavigationController, View {
    
    public weak var userActionsStream: ModelStream<ActionType?>!
    
    public func send(action: ActionType) {
        userActionsStream << action
    }
    
    
    
    
    
}



