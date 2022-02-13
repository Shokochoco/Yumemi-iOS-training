import Foundation

struct Parameter: Encodable {
    let area: String
    let date: String
}

struct Weather: Decodable {
    let weather: String
    let max_temp: Int
    let min_temp: Int
    let date: String
}

struct WeatherModel {
    let weather: String
    let maxTemp: Int
    let minTemp: Int
    let date: String
}
