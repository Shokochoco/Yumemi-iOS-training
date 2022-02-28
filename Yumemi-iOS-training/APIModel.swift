import Foundation
import YumemiWeather

class APIModel {

    func getAPI(completion: @escaping (Result<Weather, YumemiWeatherError>) -> Void) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { [weak self] in

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
                guard let weatherData = weather.data(using: .utf8)  else { return }
                let weatherDecoded = try! JSONDecoder().decode(Weather.self, from: weatherData)

                completion(.success(weatherDecoded))
            } catch YumemiWeatherError.unknownError {
                completion(.failure(YumemiWeatherError.unknownError))
            } catch YumemiWeatherError.invalidParameterError {
                completion(.failure(YumemiWeatherError.invalidParameterError))
            } catch {
                return
            }

        }

    }

}
