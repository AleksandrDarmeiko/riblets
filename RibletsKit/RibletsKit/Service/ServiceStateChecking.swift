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
