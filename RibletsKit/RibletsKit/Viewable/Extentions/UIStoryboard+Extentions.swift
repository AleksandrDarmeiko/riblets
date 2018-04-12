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
