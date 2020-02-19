import Foundation

struct RestaurantTag: Codable {
    let idRestaurantTagCategory: Int
    let categoryName: String
    let categoryPic: String
    let tagList: TagList

    enum CodingKeys: String, CodingKey {
        case idRestaurantTagCategory = "id_restaurant_tag_category"
        case categoryName = "category_name"
        case categoryPic = "category_pic"
        case tagList = "tag_list"
    }
}
