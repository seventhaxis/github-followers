//
//  FavoritesListVC.swift
//  Followers
//
//  Created by Matt Brown on 11/29/20.
//

import UIKit

final class FavoritesListVC: GFDataLoadingVC {
    private enum ViewMetrics {
        static let backgroundColor = UIColor.systemBackground
        static let tableViewRowHeight: CGFloat = 80.0
    }
    
    private var favorites = [Follower]()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }

    private func setupView() {
        navigationItem.title = "Favorites"
        navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = ViewMetrics.backgroundColor
        
        tableView.frame = view.bounds
        tableView.rowHeight = ViewMetrics.tableViewRowHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        
        view.addSubviews(tableView)
    }
    
    private func fetchFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(message: "You have not added any favorite users yet. 😕", in: self.view)
                }
                else {
                    self.favorites = favorites
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlert(title: "Uh Oh", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier) as? FavoriteCell else { fatalError() }
        let favoriteUser = favorites[indexPath.row]
        cell.configure(for: favoriteUser)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteUser = favorites[indexPath.row]
        let followerListVC = FollowerListVC(user: favoriteUser.username)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favoriteUser = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favoriteUser, actionType: .remove) { [weak self] error in
            guard let self = self, let error = error else { return }
            self.presentGFAlert(title: "Uh Oh", message: error.rawValue, buttonTitle: "OK")
        }
        
        if favorites.isEmpty { print("No more favorites. Should be showing empty state now...")}
    }
}
