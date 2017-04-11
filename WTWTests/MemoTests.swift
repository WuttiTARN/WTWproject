//
//  MemoTests.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/28/2560 BE.
//  Copyright © 2017 wphTarn. All rights reserved.
//

import XCTest
@testable import WTW

class MemoTests: XCTestCase {
    
    var memo:MemoViewController!
    
    override func setUp() {
        super.setUp()
        memo = MemoViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_get_memo(){
        
        let output = memo.getData()
        print("output memo = ",output)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
