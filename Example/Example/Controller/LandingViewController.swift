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
        // reloading in main queue from RKUIKit helper func
        collectionView.reloadDataInMainQueue()
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
            cell.infoActionClosure = { [weak self] sender in
                guard let self = self else { return }
                
                // Calculate width allowed for the tooltip. Exclude the side margins.
                let tipViewWidth = self.view.bounds.size.width - (2 * 12)
                
                // Initialize the tooltip VC
                let newToolTipVC = NativeToolTipViewController(with: sender)
                
                // Set the title
                newToolTipVC.setTitleText(with: "title text")
                
                // Set body text
                if let attributedString = newToolTipVC.getAttributedStringForBodyText(bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum") {
                    attributedString.addAttributes([.font: UIFont.systemFont(ofSize: 11.0, weight: .bold)], range: NSRange(location: 0, length: 8))
                    newToolTipVC.setBodyText(with: attributedString)
                }
                
                // Update tooltip size based on text.
                newToolTipVC.updateToolTipSize(toolTipOccupiedWith: tipViewWidth)
                newToolTipVC.loadViewIfNeeded()
                
                self.present(newToolTipVC, animated: false, completion: nil)
            }
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
