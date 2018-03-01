//
//  ServiceResponseTransmitter.swift
//  RibletsKit
//
//  Created by Alexander on 22/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation



public class ServiceTransmitter<T> : ModelStream<ServiceResponse<T>>, ServiceStateChecking {

    weak var operation: ServiceOperation<T>?
    
    init(_ initial: ServiceResponse<T>, operation: ServiceOperation<T>) {
        self.operation = operation
        super.init(initial)
    }
    
    override func notify(_ model: ServiceResponse<T>) {
        operation?.synchronizeStream(model)
    }
    
    func detach() {
        operation = nil
    }

}
