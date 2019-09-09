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
    
    var shows: [Show]? {
        didSet {
            showTableView.reloadData()
        }
    }

    var searchString: String? {
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
        let showURL =  "http://api.tvmaze.com/search/shows?q=\(searchString)"
        NetworkManager.shared.getData(from: showURL) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let showData):
                let showFromData = Show.getShowsFromData(from: showData)
                self.shows = showFromData
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}
