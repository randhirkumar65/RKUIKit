//
//  LandingViewController.swift
//  Example
//
//  Created by Randhir Kumar on 07/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit
import RKUIKit

class LandingViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var collectionView: UICollectionView!

    private var viewModel: LandingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        registerCell()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func setupViewModel() {
        viewModel = LandingViewModel(completionHandler: updateUI)
        viewModel.initializeDataSource(datasource: [LandingModel(title: "Native Popover"), LandingModel(title: "Date Formatters"), LandingModel(title: "Loading from Nib")])
    }
    
    private func registerCell() {
        // Registering collection view cell from RKUIKit helper methods
        BasicCollectionViewCell.register(on: collectionView)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let compositionalLayout = UICollectionViewCompositionalLayout { (_,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let numberOfColumns = 1
            let spacing: CGFloat = 8.0
            
            // create an item representing each card
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(50.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // create a group representing each row
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(55.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: numberOfColumns)
            group.interItemSpacing = .fixed(spacing)
            
            // create a section containing all the groups
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            return section
        }
        return compositionalLayout
    }
    
    fileprivate func updateUI() {
        collectionView.reloadData()
    }
}

// MARK: - Collection View delegate and datasource methods

extension LandingViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.noOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // deque collection view cell from RKUIKit helper methods
        let cell = BasicCollectionViewCell.dequeue(for: collectionView, at: indexPath)
        if let data = viewModel.getCellItem(atIndex: indexPath.item) {
            cell.configCell(model: data)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            // Native popover
            print("Native popover")
        case 1:
                 // Date Formatter
                 print("Date Formatter")
        case 2:
                 // From Nib
                 print("From Nib")
        default:
            break
        }
    }
    
}
