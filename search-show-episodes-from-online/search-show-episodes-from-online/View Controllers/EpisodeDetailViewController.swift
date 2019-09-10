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
    // URL to load episode: "http://api.tvmaze.com/shows/\(episideIDhere)/episodes?=summary"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
