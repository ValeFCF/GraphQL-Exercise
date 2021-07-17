//
//  MainViewController.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import UIKit

protocol MainViewControllerDelegate: NSObjectProtocol {
    func performRefresh()
}

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    internal let apollo = Network.shared.apollo
    
    internal lazy var innerView = MainView()
    
    private var launches = [LaunchPastListQuery.Data.LaunchesPast]()
    private var filteredLaunches = [LaunchPastListQuery.Data.LaunchesPast]()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "SEARCH".localized
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    override func loadView() {
        title = NSLocalizedString("APP_NAME", comment: "")
        view = innerView
        
        configNavigationBar()
        
        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        
        // Make the search bar always visible.
        navigationItem.hidesSearchBarWhenScrolling = false
        
        /** Search presents a view controller by applying normal view controller presentation semantics.
            This means that the presentation moves up the view controller hierarchy until it finds the root
            view controller or one that defines a presentation context.
        */
        
        /** Specify that this view controller determines how the search controller is presented.
            The search controller should be presented modally and match the physical size of this view controller.
        */
        definesPresentationContext = true
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.setDelegate(delegate: self)
        innerView.tableView.dataSource = self
        innerView.tableView.delegate = self
        getLaunches()
    }

    private func getLaunches() {
        changeStateView(.success)
        apollo.fetch(query: LaunchPastListQuery()) { [weak self] result in
          switch result {
          case .success(let graphQLResult):
            //print("Success! Result: \(graphQLResult)")
            
            if let launchConnection = graphQLResult.data?.launchesPast {
                let launchesPast = launchConnection.compactMap { $0 }
                self?.handleSuccess(launches: launchesPast)
            }
                    
            if let errors = graphQLResult.errors {
              let message = errors
                    .map { $0.localizedDescription }
                    .joined(separator: "\n")
                print("graphQLResult.errors: \(message)")
                self?.handleError()
            }
            
          case .failure(let error):
            print("Failure! Error: \(error)")
            self?.handleError()
          }
        }
    }
    
    private func handleSuccess(launches: [LaunchPastListQuery.Data.LaunchesPast]) {
        if launches.isEmpty {
            changeStateView(.empty)
        } else {
            self.launches = launches
            innerView.tableView.reloadData()
            changeStateView(.success)
        }
    }
    
    private func handleError() {
        changeStateView(.error)
    }
    
    private func changeStateView(_ state: MainSate) {
        innerView.changeState(state)
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    internal var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    private func filterContentForSearchText(_ searchText: String?) {
        guard let text = searchText else {
            return
        }
        filteredLaunches = launches.filter { launch in
            return (launch.missionName ?? "").lowercased().contains(text.lowercased())
        }
        innerView.tableView.reloadData()
    }
}

extension MainViewController: MainViewControllerDelegate {
    func performRefresh() {
        getLaunches()
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsInSection: Int
        if isFiltering {
            rowsInSection = filteredLaunches.count
        } else {
            rowsInSection = launches.count
        }
        if rowsInSection > 0 {
            tableView.backgroundView = nil
        } else {
            tableView.backgroundView = innerView.emptyTableView
        }
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let launch: LaunchPastListQuery.Data.LaunchesPast
        if isFiltering {
            launch = filteredLaunches[indexPath.row]
        } else {
            launch = launches[indexPath.row]
        }
        let cell = UITableViewCell()
        cell.textLabel?.text = launch.missionName
        return cell
    }
}
