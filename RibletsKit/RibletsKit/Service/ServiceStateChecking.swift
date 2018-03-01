//
//  ServiceStreamStateChecking.swift
//  RibletsKit
//
//  Created by Alexander on 22/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation


protocol ServiceStateChecking {
    
    associatedtype T
    var model: ServiceResponse<T> { get set }
    
}

extension ServiceStateChecking {
    
    public func isNone() -> Bool {
        switch model {
        case .none:
            return true
        default:
            return false
        }
    }
    
    public func isSucceeded() -> Bool {
        switch model {
        case .success(_):
            return true
        default:
            return false
        }
    }
    
    public func isError() -> Bool {
        switch model {
        case .error(_, _):
            return true
        default:
            return false
        }
    }
    
    public func isCanceled() -> Bool {
        switch model {
        case .canceled:
            return true
        default:
            return false
        }
    }
    
    public func isInProgress() -> Bool {
        switch model {
        case .inProgress:
            return true
        default:
            return false
        }
    }
    
}
