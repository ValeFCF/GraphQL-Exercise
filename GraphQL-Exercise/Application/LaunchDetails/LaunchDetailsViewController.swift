//
//  LaunchDetailsViewController.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit

protocol LaunchDetailsViewControllerDelegate: NSObjectProtocol {
    func openURL(url: URL)
}

class LaunchDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let innerView: LaunchDetailsView
    private let launch: LaunchPastListQuery.Data.LaunchesPast
    
    init(launch: LaunchPastListQuery.Data.LaunchesPast) {
        self.launch = launch
        self.innerView = LaunchDetailsView(launch: launch)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        title = "DETAILS".localized
        view = innerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        innerView.setDelegate(delegate: self)
        innerView.collectionView.dataSource = self
    }
}

extension LaunchDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rowsInSection = launch.ships?.count ?? 0
        if rowsInSection > 0 {
            innerView.shipsTitle.isHidden = false
            collectionView.backgroundView = nil
        } else {
            innerView.shipsTitle.isHidden = true
            collectionView.backgroundView = innerView.emptyCollectionView
        }
        return rowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = innerView.kCollectionViewCell
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier, for: indexPath
            ) as? LaunchDetailsCollectionViewCell else {
                fatalError("[LaunchDetailsCollectionViewCell] - \(identifier) should be registered.")
        }
        if let ship = launch.ships?[indexPath.row] {
            cell.bind(ship: ship)
        }
        return cell
    }
}

extension LaunchDetailsViewController: LaunchDetailsViewControllerDelegate {
    func openURL(url: URL) {
        let controller = WebViewController(url: url)
        navigationController?.pushViewController(controller, animated: true)
    }
}
