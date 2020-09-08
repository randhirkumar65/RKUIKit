//
//  ExampleTabbedContainerViewController.swift
//  Example
//
//  Created by Randhir Kumar on 08/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import RKUIKit

class ExampleTabbedContainerViewController: TabbedContainerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Tabbed Container View"
    }
    
    override var closeButtonTitle: String {
        return "Cancel"
    }
    
    // MARK: Display Alert
    
    public func yesCancelAlertAction(_: UIAlertAction) {
        navigationController?.popViewController(animated: true)
    }
    
    override public var closeButtonAction: (() -> Void)? {
        return {
            let alert = UIAlertController(title: "Are you sure you want to cancel?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes, Cancel", style: .cancel, handler: self.yesCancelAlertAction))
            alert.addAction(UIAlertAction(title: "Stay Here", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override var tabContainerItems: [TabbedContainerItem] {
        let tabExampleViewController1 = TabExampleViewController()
        tabExampleViewController1.navigatingDelegate = self
        tabExampleViewController1.tableViewBackgroundColor = .blue
        
        let tabExampleViewController2 = TabExampleViewController()
        tabExampleViewController2.navigatingDelegate = self
        tabExampleViewController2.tableViewBackgroundColor = .yellow
        
        let tabExampleViewController3 = TabExampleViewController()
        tabExampleViewController3.navigatingDelegate = self
        tabExampleViewController3.tableViewBackgroundColor = .purple
        
        let tabExampleViewController4 = TabExampleViewController()
        tabExampleViewController4.navigatingDelegate = self
        tabExampleViewController4.tableViewBackgroundColor = .red
        
        let item1 = TabbedContainerItem(tabTitle: "First", viewController: tabExampleViewController1)
        let item2 = TabbedContainerItem(tabTitle: "Second", viewController: tabExampleViewController2)
        let item3 = TabbedContainerItem(tabTitle: "Third", viewController: tabExampleViewController3)
        let item4 = TabbedContainerItem(tabTitle: "Fourth", viewController: tabExampleViewController4)
        return ([item1, item2, item3, item4])
    }
}
