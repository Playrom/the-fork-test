// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let michelinDetail = try? newJSONDecoder().decode(MichelinDetail.self, from: jsonData)

import Foundation

// MARK: - MichelinDetail
struct MichelinDetail: Codable {
    let isMichelin: Bool

    enum CodingKeys: String, CodingKey {
        case isMichelin = "is_michelin"
    }
}
