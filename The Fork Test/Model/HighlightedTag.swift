// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let highlightedTag = try? newJSONDecoder().decode(HighlightedTag.self, from: jsonData)

import Foundation

// MARK: - HighlightedTag
struct HighlightedTag: Codable {
    let id: Int
    let slug: String
    let indexable: Bool
    let text, type: String
}
