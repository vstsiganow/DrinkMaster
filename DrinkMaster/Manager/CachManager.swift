//
//  CachManager.swift
//  DrinkMaster
//
//  Created by vtsyganov on 18.10.2021.
//

import UIKit

class CachManager {
    static var shared = CachManager()

    private init() {}
    
    func saveDataToCache(with data: Data, response: URLResponse) {
        // извлекаем адрес, по которому будет идентифицирована картинка
        guard let url = response.url else { return }
        // запрос для поиска данных в кеше
        let request = URLRequest(url: url)
        // создать кешируемый объект
        let cachedResponse = CachedURLResponse(response: response, data: data)
        // Поместить объект в кеш
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    func getCachedImage(for url: URL) -> UIImage? {
        // запрос для поиска данных в кеше
        let request = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        
        return nil
    }
}
