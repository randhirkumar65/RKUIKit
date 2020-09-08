//
//  TabContainerTabView.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 08/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//
import UIKit

public protocol TabbedContainerTabViewDelegate: class {
    func didSelectTab(_ sender: TabContainerTabView)
}

public class TabContainerTabView: UIView, NibLoadable {
    
    @IBOutlet weak var tabButton: UIButton!
    
    // MARK: Public Properties
    
    public weak var delegate: TabbedContainerTabViewDelegate?
    
    public var isSelected: Bool = false {
        didSet {
            if isSelected {
                tabButton.setTitleColor(.green, for: .normal)
            } else {
                tabButton.setTitleColor(.lightGray, for: .normal)
            }
        }
    }
    
    // MARK: Configure
    
    public func configure(tabTitle: String) {
        tabButton.setTitle(tabTitle, for: .normal)
        tabButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    // MARK: Actions
    @IBAction func selectTabAction(_ sender: UIButton) {
        delegate?.didSelectTab(self)
    }
}
