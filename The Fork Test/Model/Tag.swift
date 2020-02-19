import Foundation

struct Tag: Codable {
    let idRestaurantTag, idRestaurantTagCategory: Int
    let tagName, picSmall: String
    let picLarge, picMobile: String
    let bannerWeb: String
    let indexable: Int
    let tagDescription, slugIndexable: String
    let idCityIndexable: Int?
    let title: String? //JSONNull?
    let seoTitle, seoDesc, seoH1: String?
    let idRestaurantTagSubstitute: Int? //JSONNull?
    let isDeleted: Int
    let displayOrder: Int?
    let isDisplayedSearch: Bool
    let searchVolume: Double?
    let isPublishedPortal: Bool
    let slugList: [String] // [JSONAny]
    let marketingBanner: String
    let marketingTitle, marketingDescription: String?
    let idRestaurantTagLevel1, idRestaurantTagLevel2: Int?
    let alternativeNameHP, alternativeNameSrp, alternativeNameRp: String?

    enum CodingKeys: String, CodingKey {
        case idRestaurantTag = "id_restaurant_tag"
        case idRestaurantTagCategory = "id_restaurant_tag_category"
        case tagName = "tag_name"
        case picSmall = "pic_small"
        case picLarge = "pic_large"
        case picMobile = "pic_mobile"
        case bannerWeb = "banner_web"
        case indexable
        case tagDescription = "tag_description"
        case slugIndexable = "slug_indexable"
        case idCityIndexable = "id_city_indexable"
        case title
        case seoTitle = "seo_title"
        case seoDesc = "seo_desc"
        case seoH1 = "seo_h1"
        case idRestaurantTagSubstitute = "id_restaurant_tag_substitute"
        case isDeleted = "is_deleted"
        case displayOrder = "display_order"
        case isDisplayedSearch = "is_displayed_search"
        case searchVolume = "search_volume"
        case isPublishedPortal = "is_published_portal"
        case slugList = "slug_list"
        case marketingBanner = "marketing_banner"
        case marketingTitle = "marketing_title"
        case marketingDescription = "marketing_description"
        case idRestaurantTagLevel1 = "id_restaurant_tag_level_1"
        case idRestaurantTagLevel2 = "id_restaurant_tag_level_2"
        case alternativeNameHP = "alternative_name_hp"
        case alternativeNameSrp = "alternative_name_srp"
        case alternativeNameRp = "alternative_name_rp"
    }
}
