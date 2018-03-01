//
//  ModelStream.swift
//  RibletsKit
//
//  Created by Alexander on 16/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation


public class ModelStream<T>: InteractorUnsubscribable {
    
    
    struct ListnerHolder : Equatable {
        
        static func ==(lhs: ModelStream<T>.ListnerHolder, rhs: ModelStream<T>.ListnerHolder) -> Bool {
            return lhs.owner === rhs.owner
        }
        
        let listner: (_ model : T) -> Void
        let owner: AnyObject
        var enabled = true
    }
    
    let serialQueue = DispatchQueue(label: "ch.alexchur.Riblets-Trip.SerialQueue",
                                    attributes: [],
                                    target: nil)
    
    init(_ initial: T) {
        privateModel = initial
    }
    
    var privateModel: T
    
    public var model: T {
        get {
            return serialQueue.sync {
                return self.privateModel
            }
        }
        
        set {
            serialQueue.sync {
                self.privateModel = newValue

                if Thread.isMainThread {
                    self.notify(newValue)
                }
                else {
                    DispatchQueue.main.async {
                        self.notify(newValue)
                    }
                }
            }
        }
    }
    
    public static func << (lhs : ModelStream<T>, rhs: T) {
        lhs.model = rhs
    }
    
    func notify(_ model: T) {
        listners.forEach { listnerHolder in
            if listnerHolder.enabled {
                listnerHolder.listner(model)
            }
        }
    }

    private var listners = [ListnerHolder]()
    
    public func listen(owner: AnyObject, _ listner : @escaping (_ model : T) -> Void) {
        let holder = ListnerHolder(listner: listner, owner: owner, enabled: true)
        listners.append(holder)
    }
    
    public func listen(owner: Interactable, _ listner : @escaping (_ model : T) -> Void) {
        let interactor = owner as! InteractorSubscribtions
        interactor.registerListeningStream(self)
        listen(owner: interactor, listner)
    }
    
    public func unsubscribe(owner: AnyObject) {
        let listners = self.listners
        listners.forEach { listnerHolder in
            if listnerHolder.owner === owner {
                let index = self.listners.index(of: listnerHolder)!
                self.listners.remove(at: index)
            }
        }
    }

    func unsubscribe(interactor: InteractorSubscribtions) {
        unsubscribe(owner: interactor)
        interactor.unregisterListeningStream(self)
    }
    
    func sleep(interactor: InteractorSubscribtions) {
        for (index, listnerHolder) in listners.enumerated() {
            if listnerHolder.owner === interactor {
                listners[index].enabled = false
            }
        }
    }
    
    func wakeUp(interactor: InteractorSubscribtions) {
        for (index, listnerHolder) in listners.enumerated() {
            if listnerHolder.owner === interactor {
                listners[index].enabled = true
            }
        }
    }
    
}


