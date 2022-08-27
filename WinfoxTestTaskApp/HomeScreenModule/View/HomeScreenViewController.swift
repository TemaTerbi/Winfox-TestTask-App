//
//  HomeScreenViewController.swift
//  WinfoxTestTaskApp
//
//  Created by TeRb1 on 26.08.2022.
//

import UIKit
import SnapKit
import Firebase

class HomeScreenViewController: UIViewController {
    
    private let refreshController = UIRefreshControl()
    var viewModel = HomeScreenViewModel()
    var places: [Places] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAllPlaces()
        bindViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        setupCollectionView()
        refreshController.beginRefreshing()
        
        refreshController.attributedTitle = NSAttributedString(string: "Загрузка...")
    }
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/4)-2, height: 200)
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: RestaurantCollectionViewCell.identifire)
        view.addSubview(collectionView)
        collectionView.addSubview(refreshController)
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(2)
        }
        collectionView.backgroundColor = .systemIndigo
    }
    
    private func bindViewModel() {
        viewModel.places.bind { places in
            self.places = places
            self.setupCollectionView()
            self.refreshController.endRefreshing()
        }
    }
}

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.identifire, for: indexPath) as! RestaurantCollectionViewCell
        let placesForSetup = places[indexPath.row]
        cell.setupData(placesForSetup)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
}
