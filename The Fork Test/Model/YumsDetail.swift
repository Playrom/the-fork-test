// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let yumsDetail = try? newJSONDecoder().decode(YumsDetail.self, from: jsonData)

import Foundation

// MARK: - YumsDetail
struct YumsDetail: Codable {
    let isSuperYums: Bool
    let yumsCount: Int

    enum CodingKeys: String, CodingKey {
        case isSuperYums = "is_super_yums"
        case yumsCount = "yums_count"
    }
}
