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

class ServiceOperationTests: XCTestCase {

    func testSuccessExecuting() {
        
        let operation = ServiceOperation<Bool>({
            $0 << .success(true)
        })
        
        
        let expectation = XCTestExpectation(description: "testSuccessExecuting")
        
        operation.stream.listen(owner: self) { model in
            switch model {
            case .success(let result):
                XCTAssert(result)
                expectation.fulfill()
            default:
                break
            }
        
        }
        
        operation.perform()
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCancelFromStream() {
        
        let expectation = XCTestExpectation(description: "testCancelFromStream")
        
        let operation = ServiceOperation<Bool>({
            Thread.sleep(forTimeInterval: 1.0)
            if $0.isCanceled() {
                expectation.fulfill()
                return
            }
            else {
                $0 << .success(true)
            }
        })
        
        operation.perform()
        operation.stream << .canceled
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testCancelFromOpearation() {
        
        let expectation = XCTestExpectation(description: "testCancelFromOpearation")
        
        let operation = ServiceOperation<Bool>({
            Thread.sleep(forTimeInterval: 1.0)
            if $0.isCanceled() {
                expectation.fulfill()
                return
            }
            else {
                $0 << .success(true)
            }
        })
        
        operation.perform()
        operation.cancel()
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testDetachingTransmitterAfterCancalation() {
        
        let expectation = XCTestExpectation(description: "testDetachingTransmitterAfterCancalation")
        let operation = ServiceOperation<Bool>({
            Thread.sleep(forTimeInterval: 1.0)
            $0 << .success(true)
            expectation.fulfill()
        })
        
        operation.perform()
        operation.cancel()
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssert(operation.stream.model == .canceled)
    }
    
    
}
