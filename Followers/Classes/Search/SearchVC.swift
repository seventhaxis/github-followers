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
    }
    
    let logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "gh-logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let usernameTextField = GFTextField(type: .userSearch)
    let searchButton = GFButton(bgColor: .systemGreen, title: "Search")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let tapToDismiss = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapToDismiss)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        
        usernameTextField.delegate = self
        searchButton.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
        
        [logoImageView, usernameTextField, searchButton].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80.0),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200.0),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
            
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: logoImageView.bottomAnchor, multiplier: 5.0), 
            usernameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 50.0),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor, constant: 50.0),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44.0),
            
            searchButton.topAnchor.constraint(equalToSystemSpacingBelow: usernameTextField.bottomAnchor, multiplier: 2.0),
            searchButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 44.0),
        ])
    }
}

private extension SearchVC {
    @objc func tapSearchButton() {
        guard usernameTextField.passesValidation, let userEntry = usernameTextField.text else {
            presentGFAlert(title: "Username Required", message: "Please enter a valid GitHub username to search for.", buttonTitle: "OK")
            return
        }
        
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
        
        print("Searching for: \(userEntry)")
        let followersVC = FollowerListVC(user: userEntry)
        navigationController?.pushViewController(followersVC, animated: true)
        return true
    }
}
