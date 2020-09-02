//
//  CollectionView+TableView+Extensions.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 02/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit

// MARK: - Collection View Helper extensions
extension UICollectionView {
    func reloadDataInMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

// MARK: - Table View Helper extensions
extension UITableView {
    func reloadDataInMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
