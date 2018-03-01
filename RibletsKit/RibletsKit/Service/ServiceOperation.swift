//
//  ServiceOperation.swift
//  RibletsKit
//
//  Created by Aleksandr on 21/02/2018.
//  Copyright © 2018 Aleksandr Darmeiko. All rights reserved.
//

import Foundation

/*!
 @brief A `ServiceOperation` defines task executing in background
 */
open class ServiceOperation<T> {
    
    public let inProgressProtection: Bool = false
    
    
    /*!
     @brief A `ServiceStream` receives data from operation
     @discussion Interactors should listen to this streams for receiving data
     */
    public let stream: ServiceStream<T>
    
    /*!
     @brief A `ServiceTransmitter` in case of cancelation
     
     Непосредственный получатель данных в блоке операции.

     С его помощью обеспечивается целостность данных в потоке. Если операция была отменена, то трансмиттер открепляется и больше не передает данные в операцию, давая возможность корректно завершить отменный участок кода.

     @discussion Interactors should listen this streams for receiving data
     */
    var transmitter: ServiceTransmitter<T>?
    public var closure: ((ServiceTransmitter<T>) -> Void)!
    
    public convenience init(_ closure: @escaping (ServiceTransmitter<T>) -> Void) {
        self.init()
        self.closure = closure
    }

    public init() {
        stream = ServiceStream(.none)
        stream.operation = self
    }
    
    public func isPerforming() -> Bool {
        return stream.isInProgress()
    }

    public func perform() {
        guard self.closure != nil else {
            fatalError("Operation with empty closure")
        }
        
        if inProgressProtection {
            if stream.model == .inProgress {
                return
            }
        }
        
        let transmitter = ServiceTransmitter<T>(stream.model, operation: self)
        self.transmitter = transmitter
        transmitter << .inProgress
        DispatchQueue.global(qos: .default).async {
            self.closure(transmitter)
        }
    }
    
    public func cancel() {
        transmitter! << .canceled
    }
    
    func synchronizeStream(_ model: ServiceResponse<T>) {
        stream.model = model
        finishIfNeeded(model)
    }

    func synchronizeTransmitter(_ model: ServiceResponse<T>) {
        transmitter?.privateModel = model
        finishIfNeeded(model)
    }

    private func finishIfNeeded(_ model: ServiceResponse<T>) {
        if shouldFinish(model: model) {
            finish()
        }
    }
    
    private func finish() {
        transmitter?.operation = nil
        self.transmitter = nil
    }

    private func shouldFinish(model: ServiceResponse<T>) -> Bool {
        switch model {
        case .success(_), .canceled, .error(_, _), .none:
            return true
        default:
            return false
        }
    }
    
}
