//
//  APIClient.swift
//  FlowControllersExample
//
//  Created by Halcyonmobile on 28/02/2018.
//  Copyright © 2018 Halcyonmobile. All rights reserved.
//

import Alamofire

struct APIClient {
    
    static func request<T: Decodable>(completion: @escaping (Result<T>) -> Void) {
        
        let path = "https://swapi.co/api/films"
        let method = HTTPMethod.get
        let parameters: [String:Any]? = nil
        let encoding = JSONEncoding.default
        let headers =  ["Accept": "application/json", "Content-Type": "application/json"]
        Alamofire.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseData { response in
                
                print("Got response with status: \(response.response?.statusCode ?? -1)")
                
                switch response.result {
                case .success(let value):
                    
                    if response.response?.statusCode != 200 {
                        let message = String(data: value, encoding: .utf8)
                        
                        let error = NSError(domain: "a", code: 0, userInfo: ["localizedDescription":message])
                        
                        completion(.failure(error))
                        
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decodedObject = try decoder.decode(T.self, from: value)

                        completion(.success(decodedObject))
                        
                    } catch let error {
                        
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                    print("Network error: \(error.localizedDescription)")
                }
                
        }
    }
    
    func getFilms(success: @escaping ([Film]) -> Void, failure: @escaping ((Error) -> Void)) {
        let path = "https://swapi.co/api/films"
        let method = HTTPMethod.get
        let parameters: [String:Any]? = nil
        let encoding = JSONEncoding.default
        let headers =  ["Accept": "application/json", "Content-Type": "application/json"]
        Alamofire.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseData { response in
                
                print("Got response with status: \(response.response?.statusCode ?? -1)")
                
                switch response.result {
                case .success(let value):
                    
                    if response.response?.statusCode != 200 {
                        let message = String(data: value, encoding: .utf8)
                        
                        let error = NSError(domain: "a", code: 0, userInfo: ["localizedDescription": message])
                        
                        failure(error)
                        
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let filmResponseModel = try decoder.decode(FilmsResponseModel.self, from: value)
                        
                        success(filmResponseModel.results)
                        
                    } catch let error {
                        
                        failure(error)
                    }
                    
                case .failure(let error):
                    failure(error)
                    print("Network error: \(error.localizedDescription)")
                }
        }
    }
    
}

