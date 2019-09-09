//
//  ViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!

    var searchString: String? = nil {
        didSet {
            showTableView.reloadData()
        }
    }
    
    var shows = [ShowWrapper]() {
        didSet {
            showTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
    }
    
    private func configureTableView() {
        showTableView.delegate = self
        showTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }

    private func loadShowSearch() {
        if let searchString = searchString {
            print("string from load data: \(searchString)")
            let showURL = "http://api.tvmaze.com/search/shows?q=\(searchString)"
            ShowAPIClient.shared.getShows(from: showURL) { (result) in
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

extension ShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showCell = showTableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! ShowTableViewCell
        let show = shows[indexPath.row]
            
        //TODO - add image helper to add image, add rating label from userwrapper
//            showCell?.showImage.image = UIImage(data: <#T##Data#>)
        showCell.showNameLabel.text = show.show.name
            
        return showCell
    }
    
}

extension ShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
        loadShowSearch()
    }
}
