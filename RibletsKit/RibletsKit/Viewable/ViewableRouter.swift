//
//  ViewableRouter.swift
//  RibletsKit
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
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
