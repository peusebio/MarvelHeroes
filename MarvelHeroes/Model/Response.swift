//
//  Response.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 16/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import Foundation

struct Response: Decodable{
    let code: Int
    let status: String
    let data: Data
}
