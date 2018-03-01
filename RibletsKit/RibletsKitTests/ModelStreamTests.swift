//
//  RibletsKitTests.swift
//  RibletsKitTests
//
//  Created by Alexander on 29/09/2017.
//  Copyright © 2017 Alexander Brin. All rights reserved.
//

import XCTest
@testable import RibletsKit

class ModelStreamTests: XCTestCase {
   
    struct TestModel {
        
        var name: String
        
    }
    
    func testInitialValue() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let stream = ModelStream<TestModel?>(nil)
        switch stream.model {
        case .none:
            XCTAssert(true)
        case .some(_):
            XCTAssert(false)
        }
        
        let stream2 = ModelStream<TestModel?>(.some(TestModel(name: "Aleksandr")))
        switch stream2.model {
        case .none:
            XCTAssert(false)
        case .some(let model):
            XCTAssert(model.name == "Aleksandr")
        }
    }
    
    func testListner() {
        
        let stream = ModelStream<TestModel?>(nil)
        
        
        var fromListner : TestModel?
        stream.listen(owner: self) { model in
            fromListner = model
        }
        
        let model = TestModel(name: "Aleksandr")
        stream << model
        
        XCTAssert(fromListner != nil)
        XCTAssert(fromListner!.name == model.name)
    }
    
    
    
    
    
}
