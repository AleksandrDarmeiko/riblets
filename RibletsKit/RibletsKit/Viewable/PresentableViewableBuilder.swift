//
//  PresentableViewBuilder.swift
//  RibletsKit
//
//  Created by Alexander on 27/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation

open class PresentableViewableBuilder<ComponentClass, RouterClass, InteractorClass, ViewControllerClass>:
    Builder<ComponentClass, RouterClass, InteractorClass>
    where InteractorClass: ViewableInteractableDependencies,
    RouterClass: ViewableRouter<InteractorClass, ViewControllerClass>,
    ViewControllerClass: View {
    
    let viewControllerClass: ViewControllerClass.Type
    
    public init(_ component: ComponentClass,
                routerClass: RouterClass.Type,
                interactorClass: InteractorClass.Type,
                viewControllerClass: ViewControllerClass.Type) {
        self.viewControllerClass = viewControllerClass
        super.init(component, routerClass: routerClass, interactorClass: interactorClass)
    }
    
    override public func buildPrimaryUnits() -> RouterClass {
        let router = super.buildPrimaryUnits()
        
        // instantiates all primary Riblet units
        let viewController = factoryViewController()
        
        // Defines primary dependencies
        router.interactor.presenter = viewController as! InteractorClass.PresenterClass
        router.viewController = viewController
        
        viewController.userActionsStream = (router.interactor.userActionsStream as! ModelStream<Optional<ViewControllerClass.ActionType>>)
        
        return router
    }
    
    
    func factoryViewController() -> ViewControllerClass  {
        return initialViewController(from: storyboardName()) as! ViewControllerClass
    }
    
    func storyboardName() -> String {
        var name = String(reflecting: viewControllerClass)
        
        let substr: (String, String) -> String = { string, suffix in
            let end = string.index(string.startIndex, offsetBy: string.count - suffix.count)
            return String(string[..<end])
        }
        
        if name.contains("ViewController") {
            name = substr(name, "ViewController")
        }
        else if name.contains("NavigationController") {
            name = substr(name, "NavigationController")
        }
        else if name.contains("Controller") {
            name = substr(name, "Controller")
        }
        
        name = name.components(separatedBy: ".").last!
        
        return name
    }
    
    func initialViewController(from storyboard: String) -> UIViewController {
        return UIStoryboard.init(name: storyboard, bundle: Bundle(for: self.viewControllerClass)).instantiateInitialViewController()!
    }
    
}
