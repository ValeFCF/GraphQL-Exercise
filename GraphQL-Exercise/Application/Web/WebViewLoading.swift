//
//  WebViewLoading.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit

internal final class WebViewLoading: UIView {
    
    // MARK: - Properties
    
    private let loadingView = LoadingView()

    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Implementation

private extension WebViewLoading {
    private func setup() {
        backgroundColor = .background
        setupLoadingView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupViewHierarchy() {
        addSubview(loadingView)
    }
    
    private func setupConstraints() {
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // Loading view
            loadingView.topAnchor.constraint(equalTo: guide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}
