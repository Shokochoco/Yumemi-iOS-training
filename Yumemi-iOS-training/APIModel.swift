import Foundation
import YumemiWeather

protocol WeatherDelegate: AnyObject {
    func appearWeather(weatherDecoded: Weather)
    func failError(error: YumemiWeatherError)
}

protocol indicatorDelegate: AnyObject {
    func indicatorStart()
    func indicatorStop()
}

class APIModel {
    
    weak var delegate: WeatherDelegate?
    weak var indicatorDelegate: indicatorDelegate?

    func getAPI() {
        
        var weatherDecoded: Weather?

        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { [weak self] in
            self?.indicatorDelegate?.indicatorStart()
            do {

                let date = Date()
                let df = DateFormatter()
                df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                let dateString = df.string(from: date)

                let parameter = Parameter(area: "tokyo", date: dateString)
                // YumemiWeather.fetchWeather(ここで使うjsonStringにencode)
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let jsonData = try encoder.encode(parameter)
                guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }

                let weather = try YumemiWeather.syncFetchWeather(jsonString)
                if let weatherData = weather.data(using: .utf8) {
                    weatherDecoded = try! JSONDecoder().decode(Weather.self, from: weatherData)
                    self?.delegate?.appearWeather(weatherDecoded: weatherDecoded!)
                } else { return }

            } catch YumemiWeatherError.unknownError {
                self?.delegate?.failError(error: YumemiWeatherError.unknownError)
            } catch YumemiWeatherError.invalidParameterError {
                self?.delegate?.failError(error: YumemiWeatherError.invalidParameterError)
            } catch {
                return
            }
            self?.indicatorDelegate?.indicatorStop()
        }

    }

}
