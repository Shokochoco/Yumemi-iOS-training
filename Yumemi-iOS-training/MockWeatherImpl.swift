import Foundation

class MockWeatherImpl: WeatherModel {
    // 返却されたweather情報を保持
    var returnWeathers: Weather

    init(weathers: Weather) {
        self.returnWeathers = weathers
    }

    func getAPI() -> Weather? {
        return self.returnWeathers
    }

}
