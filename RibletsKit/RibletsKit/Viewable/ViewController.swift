//
//  View.swift
//  RibletsKit
//
//  Created by Alexander on 01/10/2017.
//  Copyright © 2017 Alexander Brin. All rights reserved.
//

import Foundation
import UIKit

public protocol View: class {
    
    associatedtype ActionType: Any
    weak var userActionsStream: ModelStream<ActionType?>! { get set }
    
}

open class ViewController<ActionType> : UIViewController, View {
    
    public weak var userActionsStream: ModelStream<ActionType?>!

    public func addChildViewController(_ childController: UIViewController, to viewContainer: UIView) {
        viewContainer.backgroundColor = UIColor.clear
        
        if #available(iOS 9.0, *) {
            childController.loadViewIfNeeded()
        } else {
            _ = childController.view
        }
        
        addChildViewController(childController)
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        childController.view.frame = viewContainer.frame
        
        viewContainer.addSubview(childController.view)
        viewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[subview]-|",
                                                                    options: .directionLeadingToTrailing,
                                                                    metrics: nil,
                                                                    views: ["subview": childController.view]))
        
        viewContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[subview]-|",
                                                                    options: .directionLeadingToTrailing,
                                                                    metrics: nil,
                                                                    views: ["subview": childController.view]))
        
        childController.didMove(toParentViewController: self)
    }
    
    public func send(action: ActionType) {
        userActionsStream << action
    }
    
}


open class SplitViewController<ActionType> : UISplitViewController, View {
    
    public weak var userActionsStream: ModelStream<ActionType?>!
    
    public func send(action: ActionType) {
        userActionsStream << action
    }
    
}

