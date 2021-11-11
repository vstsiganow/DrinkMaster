//
//  String+Extension.swift
//  DrinkMaster
//
//  Created by vtsyganov on 08.10.2021.
//

import Foundation

extension String {
    func toCategoryCode() -> String {
        let splited = self.split(separator: "/")
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
}

extension String {
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
    
    func removingTrallingSpaces() -> String {
        guard let index = lastIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[...index])
    }
}
