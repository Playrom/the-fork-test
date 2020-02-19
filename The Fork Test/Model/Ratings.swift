// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ratings = try? newJSONDecoder().decode(Ratings.self, from: jsonData)

import Foundation

// MARK: - Ratings
struct Ratings: Codable {
    let globalRate, foodRate, serviceRate, ambienceRate: Int
    let priceRate, noiceRate, waitingRate: Int

    enum CodingKeys: String, CodingKey {
        case globalRate = "global_rate"
        case foodRate = "food_rate"
        case serviceRate = "service_rate"
        case ambienceRate = "ambience_rate"
        case priceRate = "price_rate"
        case noiceRate = "noice_rate"
        case waitingRate = "waiting_rate"
    }
}
