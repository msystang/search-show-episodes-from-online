//
//  EpisodeViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet weak var episodesTableView: UITableView!
    
    var show: Show!
    
    var showID: Int {
        showID = show.id
    }
    
    var episodes = [Episode]() {
        didSet {
            episodesTableView.reloadData()
        }
    }
    
    // URL to load episode: "http://api.tvmaze.com/shows/\(episideIDhere)/episodes?=summary"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }

}


extension EpisodeViewController: UITableViewDelegate {}

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let episodeCell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
//        episodeCell.episodeImage.image =
        episodeCell.episodeNameLabel.text = episode.name
        episodeCell.episodeSeasonEpNumLabel.text = "Season: \(episode.season) Episode: \(episode.episode)"
        
        return UITableViewCell()
    }
}
