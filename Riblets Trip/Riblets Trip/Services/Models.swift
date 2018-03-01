//
//  Models.swift
//  Riblets Trip
//
//  Created by Alexander on 23/02/2018.
//  Copyright © 2018 Aleksandr Darmeyko. All rights reserved.
//

import Foundation

struct Trip {
    let train: Train?
}

struct Train {
    let name: String
    let number: String
    let route: Route
    let shcedule: Shcedule
}

struct Route {
    let departure: String
    let arrival: String
}

struct Shcedule {
    let departure: Date
    let arrival: Date
}

