//
//  search_show_episodes_from_onlineTests.swift
//  search-show-episodes-from-onlineTests
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import XCTest
@testable import search_show_episodes_from_online

class search_show_episodes_from_onlineTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // NOTE: Ingore these tests!!! Cannot trust integrity of tests because of asynronicity.
    // TODO: Fix tests with testing catered to async URLSessions
    
    func testGetShows() {
        let testQuery = "cat"
        let testShowUrl = "http://api.tvmaze.com/search/shows?q=\(testQuery)"
        ShowAPIClient.shared.getShows(from: testShowUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                XCTAssertTrue(data != nil, "Test Failed: Could not get data")
            }
        }
    }

    func testShowsListNumber() {
        let testQuery = "cat"
        let testShowUrl = "http://api.tvmaze.com/search/shows?q=\(testQuery)"
        ShowAPIClient.shared.getShows(from: testShowUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                XCTAssertTrue(data?.count == 10, "Test Failed: Did not get 10 shows: got \(data?.count) shows")
            }
        }
    }
    
    
    func testGetEpisodes() {
        let testQuery = "cat"
        let testShowUrl = "http://api.tvmaze.com/search/shows?q=\(testQuery)"
        var showData: [Show]?
        
        ShowAPIClient.shared.getShows(from: testShowUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                showData = data
            }
        }
        
        let episodeID = showData?[0].id
        let testEpisodeUrl = "http://api.tvmaze.com/shows/\(episodeID)/episodes?=summary"
        
        EpisodeAPIClient.shared.getEpisodes(from: testEpisodeUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                XCTAssertTrue(data != nil, "Test Failed: Could not get data")
            }
        }
    }

    func testEpisodeListNumber() {
        let testQuery = "cat"
        let testShowUrl = "http://api.tvmaze.com/search/shows?q=\(testQuery)"
        var showData: [Show]?
        
        ShowAPIClient.shared.getShows(from: testShowUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                showData = data
            }
        }
        
        let episodeID = showData?[0].id
        let testEpisodeUrl = "http://api.tvmaze.com/shows/\(episodeID)/episodes?=summary"
        
        EpisodeAPIClient.shared.getEpisodes(from: testEpisodeUrl) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                XCTAssertTrue(data?.count == 2, "Test Failed: Did not get 2 shows: got \(data?.count) shows")
            }
        }
    }
}
