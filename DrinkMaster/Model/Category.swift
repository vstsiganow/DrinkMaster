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
    
    var URLCode: String {
        toCategoryURLCode()
    }
    
    var imageCode: String {
        toCategoryImageCode()
    }
    
    var title: String {
        toCategoryTitle()
    }
    
    func toCategoryTitle() -> String {
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
        
        return title
    }
    
    func toCategoryURLCode() -> String {
        let splited = name.split(separator: "/")
        var total: [String] = []
        
        for group in splited {
            let newWords = group.split(separator: " ")
            
            if newWords.count > 1 {
                let joinedWords = newWords.joined(separator: "%20")
                total.append(joinedWords)
            } else {
                let word = "\(String(newWords[0]))"
                total.append(word)
            }
        }
        return total.joined(separator: "%20/%20")
    }
    
    func toCategoryImageCode() -> String {
        let splited = name.split(separator: "/")
        var total: [String] = []
        
        for group in splited {
            let newWords = group.split(separator: " ")
            
            if newWords.count > 1 {
                let joinedWords = newWords.joined(separator: "_")
                total.append(joinedWords)
            } else {
                let word = "\(String(newWords[0]))"
                total.append(word)
            }
        }
        return total.joined(separator: "_")
    }
    
    /* Маппинг данных на источник */
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
    }
}
