//
//  EpisodeDetailViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var seasonEpNumLabel: UILabel!
    @IBOutlet weak var epDescriptionTextView: UITextView!
    
    // MARK: Properties
    var episode: Episode!
    
    //TODO: Wrap text in labels
    
    // MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureText()
        loadImage()
    }
    
    // MARK: Private Functions
    private func configureText() {
        episodeNameLabel.text = episode.name
        seasonEpNumLabel.text = "Season: \(episode.season) Episode: \(episode.number)"
        epDescriptionTextView.text = episode.fixedSummary
    }
    
    private func loadImage() {
        activityIndicator.startAnimating()
        if let imageURL = episode.image?.medium {
            ImageHelper.shared.getImage(urlStr: imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        self.activityIndicator.stopAnimating()
                        self.episodeImage.image = image
                    }
                }
            }
        } else {
            episodeImage.image = UIImage(named: "noImage")
        }
    }
}
