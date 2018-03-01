//
//  UIStoryboard+extentions.swift
//  RibletsKit
//
//  Created by Alexander on 01/03/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation


extension UIStoryboard {
    
    class func factoryRibletViewController<ViewControllerClass: View>(reflecting viewControllerClass: ViewControllerClass.Type) -> ViewControllerClass  {
        return initialRibletViewController(reflecting: viewControllerClass) as! ViewControllerClass
    }

    private class func initialRibletViewController<ViewControllerClass: View>(reflecting viewControllerClass: ViewControllerClass.Type) -> UIViewController {
        let storyboardName = ribletStoryboardName(reflecting: viewControllerClass)
        return UIStoryboard.init(name: storyboardName, bundle: Bundle(for: viewControllerClass)).instantiateInitialViewController()!
    }
    
    private class func ribletStoryboardName<ViewControllerClass: View>(reflecting viewControllerClass: ViewControllerClass.Type) -> String {
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

}
