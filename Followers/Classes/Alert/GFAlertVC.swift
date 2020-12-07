//
//  GFAlertVC.swift
//  Followers
//
//  Created by Matt Brown on 12/7/20.
//

import UIKit

final class GFAlertVC: UIViewController {
    
    private enum ViewMetrics {
        static let transparentBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        static let buttonBackgroundColor = UIColor.systemPink
        
        static let containerLayoutMargins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        static let containerBackgroundColor = UIColor.systemBackground
        static let containerCornerRadius: CGFloat = 16.0
        static let containerBorderWidth: CGFloat = 2.0
        static let containerBorderColor = UIColor.white.cgColor
        static let containerWidth: CGFloat = 280.0
        static let containerHeight: CGFloat = 220.0
        
        static let actionButtonHeight: CGFloat = 44.0
    }
    
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20.0)
    
    private let messageLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .center)
        label.numberOfLines = 4
        return label
    }()
    
    private let actionButton: GFButton!
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = ViewMetrics.containerLayoutMargins
        view.backgroundColor = ViewMetrics.containerBackgroundColor
        
        view.layer.cornerRadius = ViewMetrics.containerCornerRadius
        view.layer.borderWidth = ViewMetrics.containerBorderWidth
        view.layer.borderColor = ViewMetrics.containerBorderColor
        
        return view
    }()
    
    init(title: String, message: String, buttonTitle: String) {
        self.actionButton = GFButton(bgColor: ViewMetrics.buttonBackgroundColor, title: buttonTitle)
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        messageLabel.text = message
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = ViewMetrics.transparentBackgroundColor
        
        [containerView].forEach { view.addSubview($0) }
        [titleLabel, messageLabel, actionButton].forEach { containerView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: ViewMetrics.containerWidth),
//            containerView.heightAnchor.constraint(equalToConstant: ViewMetrics.containerHeight),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            
            actionButton.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: ViewMetrics.actionButtonHeight),
            
            messageLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3.0),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            actionButton.topAnchor.constraint(equalToSystemSpacingBelow: messageLabel.bottomAnchor, multiplier: 3.0),
        ])
    }
}

private extension GFAlertVC {
    @objc func dismissAlert() {
        dismiss(animated: true)
    }
}
