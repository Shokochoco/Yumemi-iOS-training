import Foundation

class WeatherPresenter: NSObject {

   var weatherModel: WeatherModel?

    init(weatherModel: WeatherModel) {
        super.init()
        self.weatherModel = weatherModel
    }

    func getAPI() -> Weather? {
        return weatherModel?.getAPI()
    }

}
