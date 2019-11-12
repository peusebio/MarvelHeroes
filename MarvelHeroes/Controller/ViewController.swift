//
//  ViewController.swift
//  MarvelHeroes
//
//  Created by Pedro Eusébio on 15/10/2019.
//  Copyright © 2019 Pedro Eusébio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var cellId = "cellId"
    
    var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: HeroListViewModel!
    
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView = UIActivityIndicatorView()
        indicatorView.color = UIColor.red
        indicatorView.startAnimating()
        
        title = "Marvel Heroes"
        
        tableView.isHidden = true
        tableView.separatorColor = UIColor.green
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(HeroCell.self, forCellReuseIdentifier: cellId)
        
        let request = HeroRequest.with(limit: 20)
        viewModel = HeroListViewModel(request: request, delegate: self)
        
        viewModel.fetchCharacters()
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HeroCell
        
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.hero(at: indexPath.row))
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = UIViewController()
        navigationController?.pushViewController(destination, animated: true)
        //viewModel.hero(at: indexPath.row)
    }
    
}

extension ViewController: HeroListViewModelDelegate{
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        DispatchQueue.main.async {
            // 1
            guard let newIndexPathsToReload = newIndexPathsToReload else {
                self.indicatorView.stopAnimating()
                self.tableView.isHidden = false
                self.tableView.reloadData()
                return
            }
            // 2
            let indexPathsToReload = self.visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        
        //        let title = "Warning".localizedString
        //        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        //        displayAlert(with: title , message: reason, actions: [action])
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchCharacters()
        }
    }
}

private extension ViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
