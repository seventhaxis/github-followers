//
//  FollowerListVC.swift
//  Followers
//
//  Created by Matt Brown on 12/5/20.
//

import UIKit

final class FollowerListVC: UIViewController {
    private enum ViewMetrics {
        static let bgColor = UIColor.systemBackground
        
        static let collectionViewBackgroundColor = UIColor.systemBackground
        static let collectionViewEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
        static let collectionViewMinimumItemSpacing: CGFloat = 10.0
        static let collectionViewExtraVerticalSpace: CGFloat = 30.0
    }
    
    private enum Section {
        case primary
    }
    
    private let targetUser: String
    private var followers = [Follower]()
    private var currentPage = 1
    private var hasMoreFollowers = true
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(user: String) {
        self.targetUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchFollowers(for: currentPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupView() {
        navigationItem.title = targetUser
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = ViewMetrics.bgColor
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: threeColumnFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = ViewMetrics.collectionViewBackgroundColor
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
        [collectionView].forEach { view.addSubview($0) }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else { fatalError() }
            cell.configure(for: follower)
            return cell
        })
    }
}

private extension FollowerListVC {
    func fetchFollowers(for page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: targetUser, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < NetworkManager.shared.followersPerPage { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateFollowers()
                
            case .failure(let error):
                self.presentGFAlert(title: "Uh Oh", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func updateFollowers() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.primary])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { [weak self] in
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func threeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let sidePadding = ViewMetrics.collectionViewEdgeInsets.left + ViewMetrics.collectionViewEdgeInsets.right
        let minItemSpacing = ViewMetrics.collectionViewMinimumItemSpacing
        let availableWidth = view.bounds.width - sidePadding - (minItemSpacing * 2)
        let cellWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = ViewMetrics.collectionViewEdgeInsets
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + ViewMetrics.collectionViewExtraVerticalSpace)
        return flowLayout
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndDragging(scrollView, willDecelerate: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if hasMoreFollowers && (yOffset > contentHeight - screenHeight) {
            currentPage += 1
            fetchFollowers(for: currentPage)
        }
    }
}
