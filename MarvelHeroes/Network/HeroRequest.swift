//
//  CharacterRequest.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 29/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct HeroRequest {
    var path: String {
        return "/characters"
    }
    let parameters: [String : String]
    
    static func with(limit: Int) -> HeroRequest{
        let parameters = ["limit" : "\(limit)"]
        return HeroRequest(parameters: parameters)
    }
}
