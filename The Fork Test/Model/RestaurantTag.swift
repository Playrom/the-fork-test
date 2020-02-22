import Foundation

struct RestaurantTag: Codable {
    let id: Int
    let categoryName: String
    let categoryPic: String
    let tagList: [Tag]
    
    init(dictionaryValues: RestaurantJSONTag) {
        self.id = dictionaryValues.idRestaurantTagCategory
        self.categoryName = dictionaryValues.categoryName
        self.categoryPic = dictionaryValues.categoryPic
        self.tagList = Array(dictionaryValues.tagList.values)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id_restaurant_tag_category"
        case categoryName = "category_name"
        case categoryPic = "category_pic"
        case tagList = "tag_list"
    }
}
