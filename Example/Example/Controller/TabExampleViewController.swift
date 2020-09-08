//
//  TabExampleViewController.swift
//  Example
//
//  Created by Randhir Kumar on 08/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import RKUIKit

class TabExampleViewController: UIViewController, StoryboardLoadable {
    
    // MARK: TabbedContainerViewControllerNavigating
    
    weak var navigatingDelegate: TabbedContainerViewControllerNavigating?
    
    // MARK: Public Properties
    
    var headerTitle = ""
    var tableViewBackgroundColor: UIColor = .lightGray
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        view.addSubview(stackView)
        stackView.pinActiveAnchor(.leading, to: view, constraintConstant: 16)
        view.pinActiveAnchor(.trailing, to: stackView, constraintConstant: 16)
        stackView.pinActiveAnchor(.top, to: view, constraintConstant: 100)
        stackView.pinActiveAnchor(.height, constraintConstant: 140)
    }
    
    // MARK: Private Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let nextButton = UIButton()
        nextButton.backgroundColor = .green
        nextButton.setTitle("Next Tab", for: .normal)
        nextButton.addTarget(self, action: #selector(navigateForward), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        let previousButton = UIButton()
        nextButton.backgroundColor = .red
        previousButton.setTitle("Previous Tab", for: .normal)
        previousButton.addTarget(self, action: #selector(navigateBackward), for: .touchUpInside)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(previousButton)
        
        nextButton.pinActiveAnchor(.leading, to: stackView)
        nextButton.pinActiveAnchor(.trailing, to: stackView)
        previousButton.pinActiveAnchor(.leading, to: stackView)
        previousButton.pinActiveAnchor(.trailing, to: stackView)
        
        return stackView
    }()
    
    @objc private func navigateForward() {
        navigatingDelegate?.tabbedContainerDidSelectNextController()
    }
    
    @objc private func navigateBackward() {
        navigatingDelegate?.tabbedContainerDidSelectPreviousController()
    }
    
}
