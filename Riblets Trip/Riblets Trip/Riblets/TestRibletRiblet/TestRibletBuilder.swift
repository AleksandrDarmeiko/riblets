//
//  TestRibletBuilder.swift
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
import RibletsKit


    
class TestRibletBuilder: ViewableBuilder<TestRibletComponent,
                                             TestRibletRouter,
                                             TestRibletInteractor,
                                             TestRibletPresenter,
                                             TestRibletViewController> {
    
    static func defaultBuilder(component: TestRibletComponent) -> TestRibletBuilder {
        return TestRibletBuilder(component,
                                     routerClass: TestRibletRouter.self,
                                     interactorClass: TestRibletInteractor.self,
                                     presenterClass: TestRibletPresenter.self,
                                     viewControllerClass: TestRibletViewController.self)
    }
    
    /*!
      @brief 

      @discussion 
      - Defines secondary dependencies
      - Define communication dependencies
     */
    func build() -> ViewableRoutable {
        let router = buildPrimaryUnits()
        
        router.routeSelectionBuilder = component.routeSelectionBuilder
router.interactor.tripsService = component.tripsService


        return router
    }
    
}
    

