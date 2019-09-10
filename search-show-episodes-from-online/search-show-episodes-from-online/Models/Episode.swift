//
//  Episode.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let image: imageWrapper
    let summary: String?
}

struct imageWrapper: Codable {
    let medium: String?
}
