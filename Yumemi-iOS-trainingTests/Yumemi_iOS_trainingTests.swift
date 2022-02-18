//
//  Yumemi_iOS_trainingTests.swift
//  Yumemi-iOS-trainingTests
//
//  Created by 鈴木淳子 on 2022/01/29.
//

import XCTest
@testable import Yumemi_iOS_training

class Yumemi_iOS_trainingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let presenter = WeatherPresenter(weatherModel: WeatherModelImpl())
        XCTAssert((presenter.getAPI() != nil))
        // 天気予報がsunnyだったら、画面に晴れ画像が表示されること
        let sunnyExpectation = self.expectation(description: "sunny")
        sunnyExpectation.fulfill()

        self.wait(for: [sunnyExpectation], timeout: 0.1)
        // 天気予報がcloudyだったら、画面に曇り画像が表示されること
        let cloudyExpectation = self.expectation(description: "cloudy")
        cloudyExpectation.fulfill()

        self.wait(for: [cloudyExpectation], timeout: 0.1)
        // 天気予報がrainyだったら、画面に雨画像が表示されること
        let rainyExpectation = self.expectation(description: "rainy")
        rainyExpectation.fulfill()

        self.wait(for: [rainyExpectation], timeout: 0.1)
        // 天気予報の最高気温がUILabelに反映されること
        // 天気予報の最低気温がUILabelに反映されること
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
