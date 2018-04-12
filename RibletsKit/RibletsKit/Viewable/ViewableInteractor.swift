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

public protocol ViewableInteractableDependencies : InteractableDependencies {
    
    associatedtype PresenterClass: Any
    var presenter: PresenterClass! { get set }
    
    associatedtype ActionsType: Any
    var userActionsStream: ModelStream<ActionsType?> { get }
    
}

open class ViewableInteractor<RouterProtocol, ActionsType, PresenterClass>: Interactor<RouterProtocol>, ViewableInteractableDependencies {
    
    public var presenter: PresenterClass!
    public var userActionsStream = ModelStream<ActionsType?>(nil)
    
    public required init() {
        super.init()
        userActionsStream.listen(owner: self) {
            switch $0 {
            case .none:
                break
            case .some(let action):
                self.handleUserAction(action)
            }
        }
    }
    
    open func handleUserAction(_ action: ActionsType) {
        //no-op
    }
    
    
}
