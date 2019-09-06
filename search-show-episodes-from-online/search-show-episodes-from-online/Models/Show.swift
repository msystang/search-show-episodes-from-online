//
//  Show.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct ShowWrapper: Codable {
    let score: Int
    let show: [Show]
}

struct Show: Codable {
    let id: Int
    let name: String
    let image: ImageWrapper
    
}

struct ImageWrapper: Codable {
    let medium: String
}
