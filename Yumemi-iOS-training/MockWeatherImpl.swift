import Foundation

class MockWeatherImpl: WeatherModel {
    // 返却されたweather情報を保持
    var returnWeathers: Weather
    // 呼び出された引数を記録
    var argsArea: String?

    init(weathers: Weather) {
        self.returnWeathers = weathers
    }

    func getAPI(area: String) -> Weather? {
        self.argsArea = area
        return self.returnWeathers
    }

}
