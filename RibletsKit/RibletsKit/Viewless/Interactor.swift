//
//  Interactor.swift
//  RibletsKit
//
//  Created by Alexander on 01/10/2017.
//  Copyright © 2017 Alexander Brin. All rights reserved.
//

import Foundation


public protocol Interactable : class {

    init()
    func activate()
    func deactivate()
    
    func sleep()
    func wakeUp()
    
}

public protocol InteractableDependencies : Interactable {
    
    // Compromise to avoid the circular protocol constraints.
    associatedtype RouterProtocol: Any
    var router: RouterProtocol! { get set }

}

protocol InteractorUnsubscribable: class {
    
    func unsubscribe(interactor: InteractorSubscribtions)
    func sleep(interactor: InteractorSubscribtions)
    func wakeUp(interactor: InteractorSubscribtions)
}

protocol InteractorSubscribtions: class {
    
    func registerListeningStream(_ stream: InteractorUnsubscribable)
    func unregisterListeningStream(_ stream: InteractorUnsubscribable)
    
}

open class Interactor<RouterProtocol> : InteractableDependencies, InteractorSubscribtions {
    
    public var router: RouterProtocol!
    
    public required init() {}

    public func activate() {
        didActivated()
    }
    
    public func deactivate() {
        automaticUnsubscribe()
        didDeactivated()
    }
    
    public func sleep() {
        for (_, registred) in listeningStreams.enumerated() {
            registred.sleep(interactor: self)
        }
    }
    
    public func wakeUp() {
        for (_, registred) in listeningStreams.enumerated() {
            registred.wakeUp(interactor: self)
        }
    }

    open func didActivated() {
        // do nothing
    }

    open func didDeactivated() {
        // do nothing
    }
    
    // MARK: Automatic unsubscribtions
    
    var listeningStreams = [InteractorUnsubscribable]()
    
    private func automaticUnsubscribe() {
        for (_, registred) in listeningStreams.enumerated() {
            registred.unsubscribe(interactor: self)
        }
    }
    
    func registerListeningStream(_ stream: InteractorUnsubscribable) {
        for (_, registred) in listeningStreams.enumerated() {
            if registred === stream {
                return
            }
        }
        
        listeningStreams.append(stream)
    }
    
    func unregisterListeningStream(_ stream: InteractorUnsubscribable) {
        for (index, registred) in listeningStreams.enumerated() {
            if registred === stream {
                listeningStreams.remove(at: index)
                return
            }
        }
    }
    
    
    
    
}
