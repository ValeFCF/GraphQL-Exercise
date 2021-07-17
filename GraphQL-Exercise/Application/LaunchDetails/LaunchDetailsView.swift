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
}

// MARK: - Private Constants

private extension LaunchDetailsView {
    enum Font {
        static let kern: CGFloat = 0.34
        static let title = UIFont.systemFont(ofSize: 33, weight: .heavy)
        static let description = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
}

// MARK: - Private Implementation

private extension LaunchDetailsView {
    private func setup() {
        backgroundColor = .background
        //setupEmptyView()
        setupErrorView()
        setupViewHierarchy()
        setupConstraints()
    }
    
//    private func setupEmptyView() {
//        emptyView.translatesAutoresizingMaskIntoConstraints = false
//        emptyView.button.addTarget(nil,
//                                   action: #selector(didPressRetry),
//                                   for: .touchUpInside)
//    }
    
    private func setupErrorView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewHierarchy() {
        //addSubview(trickyView)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
//            emptyView.topAnchor.constraint(equalTo: guide.topAnchor),
//            emptyView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
//            emptyView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
//            emptyView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            // Table view
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}
