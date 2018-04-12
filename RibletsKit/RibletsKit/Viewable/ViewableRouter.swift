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

public protocol ViewableRoutable: Routable {
    
    var baseViewController: UIViewController { get }
    
}

open class ViewableRouter<InteractorClass, ViewControllerProtocol>: Router<InteractorClass>, ViewableRoutable
    where InteractorClass: Interactable {
    
    public var baseViewController: UIViewController {
        get {
            return viewController as! UIViewController
        }
    }
    
    open var viewController : ViewControllerProtocol!  {
        didSet {
            if #available(iOS 9.0, *) {
                baseViewController.loadViewIfNeeded()
            } else {
                _ = baseViewController.view
            }
        }
    }

    
    
}
