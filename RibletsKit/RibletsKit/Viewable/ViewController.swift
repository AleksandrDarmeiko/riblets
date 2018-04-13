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
import UIKit

public protocol View: class {
    
    associatedtype ActionType: Any
    var userActionsStream: ModelStream<ActionType?>! { get set }
    
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

