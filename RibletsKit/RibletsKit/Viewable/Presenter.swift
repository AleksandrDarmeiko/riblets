//
//  Presenter.swift
//  RibletsKit
//
//  Created by Alexander on 01/10/2017.
//  Copyright © 2017 Alexander Brin. All rights reserved.
//

import UIKit

open class Presenter<ViewType> where ViewType: View {
    
    required public init() {
        
    }
    
    public var view: ViewType!
}

