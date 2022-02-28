import Foundation
import YumemiWeather

protocol IndicatorDelegate: AnyObject {
    func indicatorStart()
    func indicatorStop()
}

class APIModel {

    var weatherDecoded: Weather?
    var error: YumemiWeatherError?

    weak var indicatorDelegate: IndicatorDelegate?

    func getAPI(completion: @escaping (_ weatherDecoded: Weather?, _ error: YumemiWeatherError?) -> Void) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { [weak self] in

            if self?.error != nil {
                self?.error = nil
            }

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
                    self?.weatherDecoded = try! JSONDecoder().decode(Weather.self, from: weatherData)
                } else { return }

            } catch YumemiWeatherError.unknownError {
                self?.error = YumemiWeatherError.unknownError
            } catch YumemiWeatherError.invalidParameterError {
                self?.error = YumemiWeatherError.invalidParameterError
            } catch {
                return
            }
            completion(self?.weatherDecoded, self?.error)
            self?.indicatorDelegate?.indicatorStop()
        }

    }
}
