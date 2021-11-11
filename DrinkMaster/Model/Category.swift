//
//  Category.swift
//  DrinkMaster
//
//  Created by vtsyganov on 08.10.2021.
//

import Foundation

struct CategoriesResponse: Decodable {
    let drinks: [Category]
}

struct Category: Decodable {
    var name: String
    
    var code: String {
        return name.toCategoryCode()
    }
    
    var title: String {
        toCategoryTitle(name: name)
    }
    
    func toCategoryTitle(name: String) -> String {
        guard name.contains("/") else { return name }
        
        var title = ""
        var words = [String]()
        
        for word in name.split(separator: "/") {
            let newWord = String(word).removingLeadingSpaces().removingTrallingSpaces()
            words.append(newWord)
        }
        
        guard words.count > 2 else {
            title = words.joined(separator: " and ")
            return title
        }
        
        for word in words[0..<words.count - 2] {
            title += "\(word), "
        }
        
        title += "\(words[words.count - 2]) and \(words[words.count - 1])"
        print("title: \(title)")
        return title
    }
    
    /* Маппинг данных на источник */
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
