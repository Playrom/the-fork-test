import Foundation

struct MenuItem: Codable {
    
    enum ItemType: String, Codable {
        case main
        case start
        case dessert
    }
    
    var type: ItemType
    var name: String
    var price: Double?
}

struct RestaurantData: Codable {
    let idRestaurant: Int
    let restaurantUUID, name: String
    let portalURL: String
    let gpsLat, gpsLong: Double
    let address: String
    let idCity: Int
    let city: String
    let idCityZipcode: Int
    let zipcode: String
    let idCountry: Int
    let country, localeCode, phone, publicPhone: String
    let email, obfuscatedEmail: String
    let rateCount: Int
    let picsMain: PicturesMain
    let picsDiaporama: [PicturesDiaporama]
    let currencyCode: String
    let minPrice, minPriceBefore, webMaxDays, isLFTestRestaurant: Int
    let isPublishedAffiliate, isPublishedPortal, isPhoneDisplayed, cardPrice: Int
    let idRestaurantTagSpeciality, idRestaurantTagSpecialityCategory: Int
    let speciality: String
    let idSaleTypeNormal: Int
    let avgRate: Double
    let avgRateEvolution, rateDistinction: String?
    private let _restaurantTags: RestaurantTags
    var restaurantTags: [RestaurantTag] {
        return _restaurantTags.values.map({
            return RestaurantTag(dictionaryValues: $0)
        })
    }
    let highlightedTag: [HighlightedTag]
    let chefName: String?
    let menuExternalLink: URL?
    let dataDescription, hourOpen: String
    let vacation: String? //JSONNull?
    let transport: String
    let parking: String? //JSONNull?
    let otherLocalizationInfos: String?
    let nbMaxGroup: Int
    let insiderDescription, insiderTips: String? // JSONNull?
    
    var cardMenu: [MenuItem] {
        var menu = [MenuItem]()
        
        if let cardStart1 = cardStart1 {
            menu.append(MenuItem(type: .start, name: cardStart1, price: priceCardStart1))
        }
        
        if let cardStart2 = cardStart2 {
            menu.append(MenuItem(type: .start, name: cardStart2, price: priceCardStart2))
        }
        
        if let cardStart3 = cardStart3 {
            menu.append(MenuItem(type: .start, name: cardStart3, price: priceCardStart3))
        }
        
        if let cardMain1 = cardMain1 {
            menu.append(MenuItem(type: .start, name: cardMain1, price: priceCardMain1))
        }
        
        if let cardMain2 = cardMain2 {
            menu.append(MenuItem(type: .start, name: cardMain2, price: priceCardMain2))
        }
        
        if let cardMain3 = cardMain3 {
            menu.append(MenuItem(type: .start, name: cardMain3, price: priceCardMain3))
        }
        
        if let cardDessert1 = cardDessert1 {
            menu.append(MenuItem(type: .start, name: cardDessert1, price: priceCardDessert1))
        }
        
        if let cardDessert2 = cardDessert2 {
            menu.append(MenuItem(type: .start, name: cardDessert2, price: priceCardDessert2))
        }
        
        if let cardDessert3 = cardDessert3 {
            menu.append(MenuItem(type: .start, name: cardDessert3, price: priceCardDessert3))
        }
        
        return menu
    }
    
    private let cardStart1, cardStart2, cardStart3, cardMain1: String?
    private let cardMain2, cardMain3, cardDessert1, cardDessert2,  cardDessert3: String?
    private let priceCardMain1, priceCardMain2, priceCardMain3: Double?
    private let priceCardStart1, priceCardStart2, priceCardStart3: Double?
    private let priceCardDessert1, priceCardDessert2, priceCardDessert3: Double?
    let priceHalfBottleOfMineralWater, priceBottleOfMineralWater, priceBottleOfWineMax, priceBottleOfWineMin: Int?
    let priceOfCoffee: Int?
    let ratings: Ratings
    let menus: Menus
    let yumsDetail: YumsDetail
    let michelinDetail: MichelinDetail
    let tripAdvisorAvgRating: Double
    let tripAdvisorReviewCount, hasStock, isOpened: Int

    enum CodingKeys: String, CodingKey {
        case idRestaurant = "id_restaurant"
        case restaurantUUID = "restaurant_uuid"
        case name
        case portalURL = "portal_url"
        case gpsLat = "gps_lat"
        case gpsLong = "gps_long"
        case address
        case idCity = "id_city"
        case city
        case idCityZipcode = "id_city_zipcode"
        case zipcode
        case idCountry = "id_country"
        case country
        case localeCode = "locale_code"
        case phone
        case publicPhone = "public_phone"
        case email
        case obfuscatedEmail = "obfuscated_email"
        case rateCount = "rate_count"
        case picsMain = "pics_main"
        case picsDiaporama = "pics_diaporama"
        case currencyCode = "currency_code"
        case minPrice = "min_price"
        case minPriceBefore = "min_price_before"
        case webMaxDays = "web_max_days"
        case isLFTestRestaurant = "is_lf_test_restaurant"
        case isPublishedAffiliate = "is_published_affiliate"
        case isPublishedPortal = "is_published_portal"
        case isPhoneDisplayed = "is_phone_displayed"
        case cardPrice = "card_price"
        case idRestaurantTagSpeciality = "id_restaurant_tag_speciality"
        case idRestaurantTagSpecialityCategory = "id_restaurant_tag_speciality_category"
        case speciality
        case idSaleTypeNormal = "id_sale_type_normal"
        case avgRate = "avg_rate"
        case avgRateEvolution = "avg_rate_evolution"
        case rateDistinction = "rate_distinction"
        case _restaurantTags = "restaurant_tags"
        case highlightedTag = "highlighted_tag"
        case chefName = "chef_name"
        case menuExternalLink = "menu_external_link"
        case dataDescription = "description"
        case hourOpen = "hour_open"
        case vacation, transport, parking
        case otherLocalizationInfos = "other_localization_infos"
        case nbMaxGroup = "nb_max_group"
        case insiderDescription = "insider_description"
        case insiderTips = "insider_tips"
        case cardStart1 = "card_start_1"
        case cardStart2 = "card_start_2"
        case cardStart3 = "card_start_3"
        case cardMain1 = "card_main_1"
        case cardMain2 = "card_main_2"
        case cardMain3 = "card_main_3"
        case cardDessert1 = "card_dessert_1"
        case cardDessert2 = "card_dessert_2"
        case cardDessert3 = "card_dessert_3"
        case priceCardStart1 = "price_card_start_1"
        case priceCardStart2 = "price_card_start_2"
        case priceCardStart3 = "price_card_start_3"
        case priceCardMain1 = "price_card_main_1"
        case priceCardMain2 = "price_card_main_2"
        case priceCardMain3 = "price_card_main_3"
        case priceCardDessert1 = "price_card_dessert_1"
        case priceCardDessert2 = "price_card_dessert_2"
        case priceCardDessert3 = "price_card_dessert_3"
        case priceHalfBottleOfMineralWater = "price_half_bottle_of_mineral_water"
        case priceBottleOfMineralWater = "price_bottle_of_mineral_water"
        case priceBottleOfWineMax = "price_bottle_of_wine_max"
        case priceBottleOfWineMin = "price_bottle_of_wine_min"
        case priceOfCoffee = "price_of_coffee"
        case ratings, menus
        case yumsDetail = "yums_detail"
        case michelinDetail = "michelin_detail"
        case tripAdvisorAvgRating = "trip_advisor_avg_rating"
        case tripAdvisorReviewCount = "trip_advisor_review_count"
        case hasStock = "has_stock"
        case isOpened = "is_opened"
    }
}
