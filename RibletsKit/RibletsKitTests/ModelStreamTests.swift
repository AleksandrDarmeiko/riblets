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
