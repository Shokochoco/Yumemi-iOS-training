import Foundation

struct Weather: Decodable {
    let weather: String
    let max_temp: Int
    let min_temp: Int
    let date: String
}
