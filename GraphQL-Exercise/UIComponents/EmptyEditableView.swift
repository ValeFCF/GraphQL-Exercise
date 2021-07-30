//
//  EmptyEditableView.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 16/07/21.
//

import UIKit

class EmptyEditableView: UIView {
    private let stackView = UIStackView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let button = Button()
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        loadLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        backgroundColor = .background
        
        setupTitleLabel()
        setupSubtitleLabel()
        setupButton()
        setupStackView()
        addSubviews()
        setupConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: Font.title)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
    
    func setupSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: Font.description)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor(named: "SubtitleText")
    }
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowRadius = Shadow.radius
        button.layer.shadowColor = Shadow.color
        button.layer.shadowOffset = Shadow.offset
        button.layer.shadowOpacity = Shadow.opacity
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.alignment = .center
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(button)
    }
    
    func setupConstraints() {
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // stackView
            stackView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.85),
        ])
    }
}

private extension EmptyEditableView {
    enum Constants {
        static let spacing: CGFloat = 24
    }
    
    enum Font {
        static let title = UIFont.systemFont(ofSize: 22, weight: .heavy)
        static let description = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    enum Shadow {
        static let opacity: Float = 1
        static let radius: CGFloat = 16
        static let offset = CGSize(width: 0, height: 8)
        static let color = UIColor(white: 0, alpha: 0.1).cgColor
    }
}
