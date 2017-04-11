//
//  PlayViewControllerTests.swift
//  WTW
//
//  Created by wuttiTARN♡ on 1/28/2560 BE.
//  Copyright © 2017 wphTarn. All rights reserved.
//

import XCTest
@testable import WTW

class PlayTests: XCTestCase {
    
    var playModel:PlayModel!

    override func setUp() {
        super.setUp()
        playModel = PlayModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_selected_button_1_game_level_will_be_easy(){
    
        let output = playModel.getVocabDataWithLevel(level: 2)
        XCTAssertEqual(output,"Medium")
    }
    
    //urs5 120s แบ่งเป็นช่วง 12 24 36 48 60 72 84 96 108 120 method +1 เพราะจะได้ตรงกับลำดับของคำศัพท์
    // Test by inputting time and aspect to get return of the vocab id.
    func test_vocab_id_by_time(){
        
        let output = playModel.getIndexVocabByTime(time: 11)
        XCTAssertEqual(output,1)
    }
    
    func test_correct_image_id_and_selected_image_id_is_equal_2(){

        let output = playModel.verifyResult(id_correct_vocab: 2, id_selected_image: 2, selected_image: "")
        XCTAssertEqual(output,true)
    }

    func test_change_vocab(){
       
        // ถ้า current time มากกว่า target time มันจะเปลี่ยนคำศััพท์
        let output = playModel.changeVocab(target_time: 12, current_time: 30)
        XCTAssertEqual(output,true)
    }
    
//    func test_correct_image_id_is_1_and_selected_image_id_is_2(){
//        
//        let output = playModel.verifyResult(id_correct_vocab: 1, id_selected_image: 2, selected_image: "")
//        XCTAssertEqual(output,false)
//    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
