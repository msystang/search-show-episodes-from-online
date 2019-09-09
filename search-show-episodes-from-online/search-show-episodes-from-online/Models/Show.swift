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
    let shows: [Show]
}

struct Show: Codable {
    let id: Int
    let name: String
    let image: ImageWrapper
    
    static func getShowsFromData(from data: Data ) -> [Show]? {
        do {
            let shows = try JSONDecoder().decode([Show]?.self, from: data)
            return shows
        } catch {
            return nil
        }
    }
    
}

struct ImageWrapper: Codable {
    let medium: String?
}
