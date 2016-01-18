//
//  ViewController.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Azuan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LocationsViewController: UIViewController {
    var viewModel                   : LocationsViewModel!
    let disposeBag                  = DisposeBag()
    let searchController            = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView    : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        bindToViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureSearchController() {
        searchController.active = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter by location"
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    searchController.searchBar.rx_delegate.observe("searchBarCancelButtonClicked:")
            .subscribeNext({ _ in
                self.viewModel.searchText.value = ""
            }).addDisposableTo(disposeBag)
    }
    
    // MARK: - ViewModel
    func bindToViewModel() {
        searchController.searchBar.rx_text.bindTo(viewModel.searchText).addDisposableTo(disposeBag)
        
        Driver.combineLatest(
                viewModel.locationsFetched.asDriver(),
                viewModel.locationsFiltered.asDriver()) { ($0, $1) }
            .driveNext({ fetched, filtered in
                if fetched || filtered {
                    self.tableView.reloadData()
                }
            }).addDisposableTo(disposeBag)
    }
}

// MARK: -  UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSectionsInTableView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getLocations().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = viewModel.readingForRowAtIndexPath(indexPath).location.name
        return cell
    }
}
