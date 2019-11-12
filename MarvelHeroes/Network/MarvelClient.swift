//
//  MarvelApiClient.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 16/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

class MarvelClient {
    
    private lazy var baseURL: URL = {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }()
    
    func fetchCharacters(with request: HeroRequest, offset: Int, completion: @escaping (Response) -> ()){
        let session = URLSession.shared
        
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        let parameters = ["apikey" : "ab5e2b9926f6e2a161ceb7bd813b0370", "offset" : "\(offset)"].merging(request.parameters, uniquingKeysWith: +)
        var encodedUrlRequest = urlRequest.encode(with: parameters)
        
        print(encodedUrlRequest)
        
        encodedUrlRequest.httpMethod = "GET"
        encodedUrlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        encodedUrlRequest.setValue("https://developer.marvel.com/docs", forHTTPHeaderField: "Referer")
        
        let task = session.dataTask(with: encodedUrlRequest, completionHandler: { data, response, error in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let serverResponse = try decoder.decode(Response.self, from: data)
                    completion(serverResponse)
                } catch let error {
                    print(error)
                }
            }
        })
        task.resume()
    }
}
