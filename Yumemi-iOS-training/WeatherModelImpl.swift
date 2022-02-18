import Foundation
import UIKit
import YumemiWeather

protocol WeatherModel {
    func getAPI()  -> Weather?
}

class WeatherModelImpl: WeatherModel {

    func getAPI() -> Weather? {
        
        do {
            // 日付
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let dateString = df.string(from: date)

            let parameter = Parameter(area: "tokyo", date: dateString)
            // YumemiWeather.fetchWeather(ここで使うjsonStringにencode)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(parameter)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else { return nil }

            let weather = try YumemiWeather.fetchWeather(jsonString)
            let weatherData = weather.data(using: .utf8)
            let weatherDecoded = try! JSONDecoder().decode(Weather.self, from: weatherData!)

            return weatherDecoded
            
        } catch YumemiWeatherError.unknownError {
            return nil 
        } catch YumemiWeatherError.invalidParameterError {
            return nil
        } catch {
            return nil
        }

    }

}
