//
//  ImageManager.swift
//  DrinkMaster
//
//  Created by vtsyganov on 18.10.2021.
//

import UIKit

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func getImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard url == response.url else { return }
            
            completion(data, response)
        }.resume()
    }
    
}
