//
//  EpisodeDetailViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var seasonEpNumLabel: UILabel!
    @IBOutlet weak var epDescriptionTextView: UITextView!
    
    var episode: Episode!
    
    //TODO: Remove HTML <> in summary
    //TODO: Wrap text in labels
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureText()
        loadImage()
    }
    
    private func configureText() {
        episodeNameLabel.text = episode.name
        seasonEpNumLabel.text = "Season: \(episode.season) Episode: \(episode.number)"
        epDescriptionTextView.text = episode.summary
    }
    
    private func loadImage() {
        if let imageURL = episode.image?.medium {
            ImageHelper.shared.getImage(urlStr: imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        self.episodeImage.image = image
                    }
                }
            }
        } else {
            episodeImage.image = UIImage(named: "noImage")
        }
    }
}
