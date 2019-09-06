//
//  ViewController.swift
//  search-show-episodes-from-online
//
//  Created by Sunni Tang on 9/6/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    // URL to load shows: "http://api.tvmaze.com/search/shows?q=\(searchResultHere)"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showTableView: UITableView!
    
    var shows: [Show]? {
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

}

extension ShowViewController: UITableViewDelegate {}

extension ShowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ShowViewController: UISearchBarDelegate {}
