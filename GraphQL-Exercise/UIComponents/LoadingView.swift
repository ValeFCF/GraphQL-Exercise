//
//  LoadingView.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import UIKit

class LoadingView: UIView {
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        loadLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadLayout() {
        backgroundColor = .background
        
        setupActivityLoader()
        addSubviews()
        setupConstraints()
    }
    
    private func setupActivityLoader() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    private func addSubviews() {
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: Constants.size),
            activityIndicator.heightAnchor.constraint(equalToConstant: Constants.size)
        ])
    }
}

private extension LoadingView {
    enum Constants {
        static let size: CGFloat = 70
    }
}

