//
//  EpisodeAPIClient.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

class EpisodeAPIClient {
    private init() {}
    
    static let shared = EpisodeAPIClient()
    
    func getEpisodes(from urlStr: String, completionHandler: @escaping (Result<[Episode], AppError>) -> ()) {
        
        NetworkManager.shared.getData(from: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let episodeInfo = try JSONDecoder().decode([Episode].self, from: data)
                    completionHandler(.success(episodeInfo))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
