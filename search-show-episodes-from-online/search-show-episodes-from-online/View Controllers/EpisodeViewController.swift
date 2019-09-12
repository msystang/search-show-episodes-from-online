//
//  EpisodeViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    //TODO: Wrap text in labels
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    var show: Show!

    var showID: Int {
        return show.id
    }

    var episodes = [Episode]() {
        didSet {
            episodesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadEpisodes()
    }
    
    private func configureTableView() {
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
    }
    
    private func loadEpisodes() {
        let episodesURL = "http://api.tvmaze.com/shows/\(showID)/episodes"
    
        EpisodeAPIClient.shared.getEpisodes(from: episodesURL) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let episodesFromData):
                    self.episodes = episodesFromData
                }
            }
        }
    }
    
    //TODO: refactor errors without fatalError?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = episodesTableView.indexPathForSelectedRow else { fatalError("No cell selected")}
        guard segue.identifier == "episodeCellToDetailSegue" else { fatalError("Unidentified segue")}
        guard let epDetailVC = segue.destination as? EpisodeDetailViewController else { fatalError("No destination") }
        
        epDetailVC.episode = episodes[selectedIndex.row]
    }
    
}


extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let episodeCell = episodesTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        
        episodeCell.activityIndicator.hidesWhenStopped  == true
        episodeCell.activityIndicator.startAnimating()
        
        if let imageURL = episode.image?.medium {
        ImageHelper.shared
            .getImage(urlStr: imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        episodeCell.activityIndicator.stopAnimating()
                        episodeCell.episodeImage.image = image
                    }
                }
            }
        } else {
            episodeCell.episodeImage.image = UIImage(named: "noImage")
        }

        episodeCell.episodeNameLabel.text = episode.name
        episodeCell.episodeSeasonEpNumLabel.text = "Season: \(episode.season) Episode: \(episode.number)"
        
        return episodeCell
    }
}
