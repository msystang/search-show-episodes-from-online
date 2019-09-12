//
//  ViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    //TODO: Wrap text in labels
    
    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!
    
    // MARK: Computed Properties
    var searchString: String? = nil {
        didSet {
            showTableView.reloadData()
            loadShowSearch()
        }
    }
    
    var shows = [ShowWrapper]() {
        didSet {
            showTableView.reloadData()
        }
    }
    
    // MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
    }
    
    // MARK: Private Functions
    private func configureTableView() {
        showTableView.delegate = self
        showTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }

    private func loadShowSearch() {
        if let searchString = searchString {
            let showURL = "http://api.tvmaze.com/search/shows?q=\(searchString)"
            ShowAPIClient.shared.getShows(from: showURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let showsFromData):
                        self.shows = showsFromData
                    }
                }
            }
        }
    }
    
    // MARK: Navigation Functions
    //TODO: refactor errors without fatalError?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = showTableView.indexPathForSelectedRow else {
            fatalError("No cell selected")}
        guard segue.identifier == "showCellToEpisodesSegue" else { fatalError("Unidentified segue")}
        guard let episodesVC = segue.destination as? EpisodeViewController else { fatalError("No destination") }
        
        episodesVC.show = shows[selectedIndex.row].show
    }
    
}

extension ShowViewController: UITableViewDelegate {
    // MARK: TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension ShowViewController: UITableViewDataSource {
    // MARK: TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showCell = showTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! ShowTableViewCell
        let show = shows[indexPath.row]
    
        showCell.activityIndicator.startAnimating()
        
        if let imageURL = show.show.image?.medium {
            ImageHelper.shared.getImage(urlStr: imageURL) { (result) in
                DispatchQueue.main.async {
                    switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let image):
                            showCell.showImage.image = image
                            showCell.activityIndicator.stopAnimating()
                    }
                }
            }
        } else {
            showCell.showImage.image = UIImage(named: "noImage")
        }
        
        showCell.showNameLabel.text = show.show.name
        showCell.ratingLabel.text = "Rating: \(String(format: "%.1f", show.score))"
            
        return showCell
    }
    
}

extension ShowViewController: UISearchBarDelegate {
    // MARK: SearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
