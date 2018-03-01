//
//  ViewableInteractor.swift
//  RibletsKit
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
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
