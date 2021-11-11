//
//  NetworkManager.swift
//  DrinkMaster
//
//  Created by vtsyganov on 18.10.2021.
//

import Foundation

enum NetworkError: Error {
    case noData
    case wrongURL
}

protocol NetworkClient {
    /* completion определяет ассинхронность функции */
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void)
    func getShortDrinks(categoryCode: String, completion: @escaping (Result<[ShortDrink], Error>) -> Void)
    func getDrink(drinkId: String, completion: @escaping (Result<Drink, Error>) -> Void)
}

class NetworkManager: NetworkClient {
    static var shared = NetworkManager()
    
    private init() {}
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list")
        else {
            completion(.failure(NetworkError.wrongURL)) // завершаем запрос с ошибкой
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.noData)) // завершаем запрос с ошибкой
                return
            }
            
            do {
                let decoder = JSONDecoder() // определяем тип декодера данных
                let response = try decoder.decode(CategoriesResponse.self, from: data) // пытаемся декодировать полученные данные
                
                completion(.success(response.drinks)) // завершаем запрос с успехом
            } catch(let error) {
                completion(.failure(error))  // завершаем запрос с ошибкой
            }
        })
        dataTask.resume()
    }
    
    func getShortDrinks(categoryCode: String, completion: @escaping (Result<[ShortDrink], Error>) -> Void) {
        let session = URLSession.shared
        
        let strURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=" + categoryCode
        
        guard let url = URL(string: strURL)
        else {
            completion(.failure(NetworkError.wrongURL)) // завершаем запрос с ошибкой
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.noData)) // завершаем запрос с ошибкой
                return
            }
            do {
                let decoder = JSONDecoder() // определяем тип декодера данных
                let response = try decoder.decode(ShortDrinkResponse.self, from: data) // пытаемся декодировать полученные данные
                
                completion(.success(response.drinks)) // завершаем запрос с успехом
            } catch(let error) {
                completion(.failure(error))  // завершаем запрос с ошибкой
            }
        })
        dataTask.resume()
    }
    
    func getDrink(drinkId: String, completion: @escaping (Result<Drink, Error>) -> Void) {
        let session = URLSession.shared
        
        let strURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" + drinkId
        
        guard let url = URL(string: strURL)
        else {
            completion(.failure(NetworkError.wrongURL)) // завершаем запрос с ошибкой
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.noData)) // завершаем запрос с ошибкой
                return
            }
            
            do {
                let decoder = JSONDecoder() // определяем тип декодера данных
                let response = try decoder.decode(DrinkResponse.self, from: data) // пытаемся декодировать полученные данные
                
                completion(.success(response.drinks)) // завершаем запрос с успехом
            } catch(let error) {
                completion(.failure(error))  // завершаем запрос с ошибкой
            }
        })
        dataTask.resume()
    }
}
