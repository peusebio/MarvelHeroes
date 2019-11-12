//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 12/11/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct Hero: Decodable{
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
}
