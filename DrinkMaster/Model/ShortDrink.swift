//
//  ShortDrink.swift
//  DrinkMaster
//
//  Created by vtsyganov on 18.10.2021.
//

struct ShortDrinkResponse: Decodable {
    let drinks: [ShortDrink]
}

struct ShortDrink: Decodable {
    var id: String
    var name: String
    var imageURL: String
    
    /* Маппинг данных на источник */
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
    }
}
