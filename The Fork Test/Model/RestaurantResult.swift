import Foundation

struct RestaurantResult: Codable {
    let result: Int
    let resultCode: String?
    let resultDetail: String
    let resultMessage: String
    let resultCached: String?
    let data: RestaurantData
    let sync: [String] // [JSONAny]

    enum CodingKeys: String, CodingKey {
        case result
        case resultCode = "result_code"
        case resultDetail = "result_detail"
        case resultMessage = "result_msg"
        case resultCached = "result_cached"
        case data, sync
    }
}
