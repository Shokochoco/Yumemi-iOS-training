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

    func testGetAPI() throws {
        let testWeather: Weather = Weather(weather: "sunny", max_temp: 20, min_temp: 5 , date: "2020-04-01T12:00:00+09:00")

        let mockWeatherImpl = MockWeatherImpl(weathers: testWeather)

        let weather = mockWeatherImpl.getAPI(area: "tokyo")
        XCTAssertEqual(weather?.weather, "sunny")
        XCTAssertEqual(weather?.max_temp, 20)
        XCTAssertEqual(weather?.min_temp, 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
