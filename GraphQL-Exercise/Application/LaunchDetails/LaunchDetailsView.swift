//
//  LaunchDetailsView.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit

internal final class LaunchDetailsView: UIView {
    
    // MARK: - Properties
    
    private let launch: LaunchPastListQuery.Data.LaunchesPast
    
    let kCollectionViewCell = "kCollectionViewCell"
    lazy var collectionView: UICollectionView = {
        let itemWidth = (UIScreen.main.bounds.width / 2) - 20
        let itemHeight = itemWidth * 0.8
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10,
                                                         left: 10,
                                                         bottom: 10,
                                                         right: 10)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .background
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LaunchDetailsCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: kCollectionViewCell)
        return collectionView
    }()
    
    internal lazy var emptyCollectionView: EmptyEditableView = {
        let emptyCollectionView = EmptyEditableView()
        emptyCollectionView.subtitleLabel.text = "NO_RESULTS_COLLECTION_VIEW".localized
        emptyCollectionView.button.removeFromSuperview()
        emptyCollectionView.titleLabel.removeFromSuperview()
        return emptyCollectionView
    }()
    
    let featuredView = FeaturedView()

    // MARK: - Initialization
    
    init(launch: LaunchPastListQuery.Data.LaunchesPast) {
        self.launch = launch
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    weak var delegate: LaunchDetailsViewControllerDelegate?
    func setDelegate(delegate: LaunchDetailsViewControllerDelegate) {
        self.delegate = delegate
    }
}

// MARK: - Private Implementation

private extension LaunchDetailsView {
    private func setup() {
        backgroundColor = .background
        setupFeaturedView()
        setupErrorView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupFeaturedView() {
        featuredView.titleLabel.text = launch.missionName
        featuredView.dateLabel.text = launch.launchDateLocal?.dateFormatted
        featuredView.siteLabel.text = launch.launchSite?.siteNameLong
        if let rocketName = launch.rocket?.rocketName {
            featuredView.rocketLabel.text = rocketName
        }
        featuredView.translatesAutoresizingMaskIntoConstraints = false
        featuredView.webButton.addTarget(nil,
                                         action: #selector(didPressWebButton),
                                         for: .touchUpInside)
        featuredView.videoButton.addTarget(nil,
                                           action: #selector(didPressVideoButton),
                                           for: .touchUpInside)
        if launch.links?.articleLink == nil {
            featuredView.webButton.isHidden = true
        }
        if launch.links?.videoLink == nil {
            featuredView.videoButton.isHidden = true
        }
    }
    
    private func setupErrorView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewHierarchy() {
        addSubview(featuredView)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            featuredView.topAnchor.constraint(equalTo: guide.topAnchor),
            featuredView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            featuredView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            featuredView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 5),
            
            // Collection view
            collectionView.topAnchor.constraint(equalTo: featuredView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

private extension LaunchDetailsView {
    @objc func didPressWebButton() {
        guard let stringUrl = launch.links?.articleLink,
            let url = URL(string: stringUrl) else {
            return
        }
        delegate?.openURL(url: url)
    }
    
    @objc func didPressVideoButton() {
        guard let stringUrl = launch.links?.videoLink else {
            return
        }
        let fullURL = stringUrl.split{$0 == "/"}.map(String.init)
        let newUrl = "https://www.youtube.com/embed/\(fullURL[2])"
        guard let url = URL(string: newUrl) else {
            return
        }
        delegate?.openURL(url: url)
    }
}
