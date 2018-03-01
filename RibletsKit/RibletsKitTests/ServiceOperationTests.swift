//
//  ServiceOperationTests.swift
//  RibletsKitTests
//
//  Created by Alexander on 22/02/2018.
//  Copyright © 2018 Alexander Brin. All rights reserved.
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
