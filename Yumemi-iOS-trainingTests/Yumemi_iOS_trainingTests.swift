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

    func testPresenter() throws {
        let testWeather: Weather = Weather(weather: "sunny", max_temp: 20, min_temp: 5,date: "2020-04-01T12:00:00+09:00")
        let presenter = WeatherPresenter(weatherModel: MockWeatherImpl(weathers: testWeather))
        let weather = presenter.getAPI()
        XCTAssertEqual(weather, testWeather)
    }

    func testViewController() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension Weather: Equatable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.weather == rhs.weather && lhs.max_temp == rhs.max_temp && lhs.min_temp == rhs.min_temp && lhs.date == rhs.date
    }
}
