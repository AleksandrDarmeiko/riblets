//
//  ServiceResponse.swift
//  RibletsKit
//
//  Created by Alexander on 22/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
//

import Foundation


public enum ServiceResponse<T> : Equatable {

    case error(Int, String)
    case inProgress
    case none
    case success(T)
    case canceled

    public static func ==(lhs: ServiceResponse<T>, rhs: ServiceResponse<T>) -> Bool {
        switch (lhs, rhs) {
        case (.success(_), .success(_)),
             (.none, .none),
             (.inProgress, .inProgress),
             (.canceled, .canceled),
             (.error(_, _), .error(_, _)):
            return true
        default:
            return false
        }
    }
    
}

