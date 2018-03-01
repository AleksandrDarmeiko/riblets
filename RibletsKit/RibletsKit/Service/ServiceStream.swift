//
//  StateStream.swift
//  RibletsKit
//
//  Created by Alexander on 21/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation

public class ServiceStream<T> : ModelStream<ServiceResponse<T>>, ServiceStateChecking {

    weak var operation: ServiceOperation<T>!
    
    override init(_ initial: ServiceResponse<T>) {
        super.init(initial)
    }
    
    public override var model: ServiceResponse<T> {
        get {
            return super.model
        }
        set {
            operation.synchronizeTransmitter(newValue)
            super.model = newValue
        }
    }
    
    
}



