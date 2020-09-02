//
//  NibLoadable.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 02/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit

public protocol NibLoadable: class {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
}

public extension NibLoadable {
    
    static var nibName: String {
        return String(describing: self.self)
    }
    
    static var nibBundle: Bundle {
        return Bundle(for: self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
    
}

public extension NibLoadable where Self: UIView {
    //swiftlint:disable force_cast
    static var loadFromNib: Self {
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
    
    static var loadFromNibWithFileOwner: UIView {
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Error loading \(self) from nib")
        }
        return view
    }
    
    static func register(on tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    static func register(on collectionView: UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
}

public extension NibLoadable where Self: UITableViewCell {

    static func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: nibName, for: indexPath) as! Self
    }
    
}

public extension NibLoadable where Self: UICollectionViewCell {
    static func dequeue(for collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as! Self
    }
    
}
