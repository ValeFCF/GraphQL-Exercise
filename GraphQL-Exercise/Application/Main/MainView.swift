//
//  MainView.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import UIKit

internal final class MainView: UIView {
    
    // MARK: - Properties
    
    private let loadingView = LoadingView()
    private let trickyView = UIView()
    
    internal lazy var errorView: EmptyEditableView = {
        let emptyView = EmptyEditableView()
        emptyView.subtitleLabel.text = "ERROR_DESCRIPTION".localized
        emptyView.button.setTitle("RETRY".localized, for: .normal)
        emptyView.titleLabel.text = "ERROR_TITLE".localized
        return emptyView
    }()
    
    internal lazy var emptyView: EmptyEditableView = {
        let emptyView = EmptyEditableView()
        emptyView.subtitleLabel.text = "NO_RESULTS_YET_DESCRIPTION".localized
        emptyView.button.setTitle("RETRY".localized, for: .normal)
        emptyView.titleLabel.text = "NO_RESULTS_YET".localized
        return emptyView
    }()
    
    internal lazy var emptyTableView: EmptyEditableView = {
        let emptyTableView = EmptyEditableView()
        emptyTableView.subtitleLabel.text = "NO_RESULTS_SEARCH_TABLE_VIEW".localized
        emptyTableView.button.removeFromSuperview()
        emptyTableView.titleLabel.removeFromSuperview()
        return emptyTableView
    }()
    
    let kTableViewCell = "kTableViewCell"
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CounterTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: kTableViewCell)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshTableView),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.allowsMultipleSelectionDuringEditing = true
        return tableView
    }()

    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    weak var delegate: MainViewControllerDelegate?
    func setDelegate(delegate: MainViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func changeState(_ state: MainSate) {
        switch state {
        case .loading:
            loadingView.isHidden = false
            errorView.isHidden = true
            emptyView.isHidden = true
            tableView.isHidden = true
        case .error:
            loadingView.isHidden = true
            errorView.isHidden = false
            emptyView.isHidden = true
            tableView.isHidden = true
        case .empty:
            loadingView.isHidden = true
            errorView.isHidden = true
            emptyView.isHidden = false
            tableView.isHidden = true
        case .success:
            loadingView.isHidden = true
            errorView.isHidden = true
            emptyView.isHidden = true
            tableView.isHidden = false
        }
    }
}

// MARK: - Private Constants

private extension MainView {
    enum Font {
        static let kern: CGFloat = 0.34
        static let title = UIFont.systemFont(ofSize: 33, weight: .heavy)
        static let description = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
}

// MARK: - Private Implementation

private extension MainView {
    private func setup() {
        backgroundColor = .background
        trickyView.translatesAutoresizingMaskIntoConstraints = false
        setupEmptyView()
        setupErrorView()
        setupLoadingView()
        setupTableView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.button.addTarget(nil,
                                   action: #selector(didPressRetry),
                                   for: .touchUpInside)
    }
    
    private func setupErrorView() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.button.addTarget(nil,
                                   action: #selector(didPressRetry),
                                   for: .touchUpInside)
    }
    
    private func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewHierarchy() {
        addSubview(trickyView)
        addSubview(tableView)
        addSubview(emptyView)
        addSubview(errorView)
        addSubview(loadingView)
    }
    
    private func setupConstraints() {
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            /// trickyView was added to avoid scrolling - prefersLargeTitles
            trickyView.topAnchor.constraint(equalTo: guide.topAnchor),
            trickyView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            trickyView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            trickyView.heightAnchor.constraint(equalToConstant: 0.01),
            
            
            // Empty view
            emptyView.topAnchor.constraint(equalTo: guide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            // Error view
            errorView.topAnchor.constraint(equalTo: guide.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            // Loading view
            loadingView.topAnchor.constraint(equalTo: guide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            // Table view
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

private extension MainView {
    @objc func didPressRetry() {
        delegate?.performRefresh()
    }
    
    @objc func refreshTableView(_ refreshControl: UIRefreshControl) {
        delegate?.performRefresh()
        refreshControl.endRefreshing()
    }
}
