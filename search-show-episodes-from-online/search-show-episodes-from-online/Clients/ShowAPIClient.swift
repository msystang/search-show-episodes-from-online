//
//  ShowAPIClient.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

class ShowAPIClient {
    private init() {}
    
    // MARK: Static Properties
    static let shared = ShowAPIClient()
    
    // MARK: Internal Methods
    func getShows(from urlStr: String, completionHandler: @escaping (Result<[ShowWrapper], AppError>) -> ()) {
        
        NetworkManager.shared.getData(from: urlStr) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let showInfo = try JSONDecoder().decode([ShowWrapper].self, from: data)
                    completionHandler(.success(showInfo))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}

