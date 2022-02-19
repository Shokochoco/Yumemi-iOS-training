import Foundation

class WeatherPresenter: NSObject {

   var weatherModel: WeatherModel?

    init(weatherModel: WeatherModel) {
        super.init()
        self.weatherModel = weatherModel
    }

    func getAPI(area: String) -> Weather? {
        return weatherModel?.getAPI(area: area)
    }

}
