//
//  SearchVC.swift
//  Followers
//
//  Created by Matt Brown on 11/29/20.
//

import UIKit

final class SearchVC: UIViewController {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemBackground
        static let directionalMargins = NSDirectionalEdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50)
        
        static let logoWidth: CGFloat = 200.0
        static let usernameTextFieldHeight: CGFloat = 44.0
        
        static let smallTopPadding: CGFloat = 20.0
        static let normalTopPadding: CGFloat = 80.0
    }
    
    private let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = GFResource.Image.ghLogo
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let usernameTextField = GFTextField(type: .userSearch)
    private let searchButton = GFButton(bgColor: .systemGreen, title: "Search")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let tapToDismiss = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapToDismiss)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
    }
    
    private func setupView() {
        view.directionalLayoutMargins = ViewMetrics.directionalMargins
        view.backgroundColor = ViewMetrics.backgroundColor
        
        usernameTextField.delegate = self
        searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
        
        let topPaddingConstant = (DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed) ? ViewMetrics.smallTopPadding : ViewMetrics.normalTopPadding
        
        view.addSubviews(logoImageView, usernameTextField, searchButton)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topPaddingConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: ViewMetrics.logoWidth),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: logoImageView.bottomAnchor, multiplier: 5.0), 
            usernameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: ViewMetrics.usernameTextFieldHeight),
            
            searchButton.topAnchor.constraint(equalToSystemSpacingBelow: usernameTextField.bottomAnchor, multiplier: 2.0),
            searchButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}

private extension SearchVC {
    @objc func tapSearchButton() {
        guard usernameTextField.passesValidation, let userEntry = usernameTextField.text else {
            presentGFAlert(title: "Username Required", message: "Please enter a valid GitHub username to search for.", buttonTitle: "OK")
            return
        }
        
        usernameTextField.resignFirstResponder()
        let followersVC = FollowerListVC(user: userEntry)
        navigationController?.pushViewController(followersVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let gfTextField = textField as? GFTextField, gfTextField.passesValidation, let userEntry = gfTextField.text else {
            presentGFAlert(title: "Username Required", message: "Please enter a valid GitHub username to search for.", buttonTitle: "OK")
            return false
        }
        
        usernameTextField.resignFirstResponder()
        let followersVC = FollowerListVC(user: userEntry)
        navigationController?.pushViewController(followersVC, animated: true)
        return true
    }
}
