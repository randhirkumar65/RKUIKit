//
//  TabbedContainerViewController.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 08/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit

public struct TabbedContainerItem {
    
    let tabTitle: String
    let viewController: UIViewController
    
    public init(tabTitle: String, viewController: UIViewController) {
        self.tabTitle = tabTitle
        self.viewController = viewController
    }
    
}
open class TabbedContainerViewController: UIViewController {
    
    // MARK: Public Properties
    
    open var tabContainerItems: [TabbedContainerItem] {
        return [TabbedContainerItem]()
    }
    
    open var closeButtonTitle: String {
        return "Close"
    }
    
    open var closeButtonAction: (() -> Void)? {
        return nil
    }
    
    public var currentViewController: UIViewController?

    // MARK: Private Properties
    
    private var tabContainerView = UIView(frame: .zero)
    private var tabContainerStackView = UIStackView(frame: .zero)
    private var tabIndicatorView = UIView(frame: .zero)
    private var tabBottomLineView = UIView(frame: .zero)
    private var viewControllerContainerView = UIView(frame: .zero)
    
    private var tabs = [TabContainerTabView]()
    private var viewControllers = [UIViewController]()
    private var newViewController: UIViewController?
    private var currentTabIndex = 0
    private var isNavigating: Bool = false
    private let animationDuration = 0.2
    
    private var tabIndicatorLeadingConstraint: NSLayoutConstraint?
    private var currentViewControllerLeadingConstraint: NSLayoutConstraint?
    private var currentViewControllerTrailingConstraint: NSLayoutConstraint?
    
    // MARK: View Life Cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        layOutViews()
        configureTabItems()
    }
    
    @objc private func confirmCancel() {
         closeButtonAction?()
    }
    
    // MARK: Configure UI
    
    private func layOutViews() {
        let closeButton = UIBarButtonItem(title: closeButtonTitle, style: .plain, target: self, action: #selector(confirmCancel))
        navigationItem.leftBarButtonItem = closeButton

        view.backgroundColor = .white
        view.addSubview(tabContainerView)
        view.addSubview(viewControllerContainerView)
        tabContainerView.addSubview(tabContainerStackView)
        tabContainerView.addSubview(tabBottomLineView)
        tabContainerView.addSubview(tabIndicatorView)
         
        tabContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerView.pinActiveAnchor(.height, constraintConstant: 40)
        tabContainerView.pinActiveAnchor(.leading, to: view)
        tabContainerView.pinActiveAnchor(.trailing, to: view)
        tabContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabContainerView.bottomAnchor.constraint(equalTo: viewControllerContainerView.topAnchor).isActive = true
        tabContainerView.backgroundColor = .lightGray

        viewControllerContainerView.translatesAutoresizingMaskIntoConstraints = false
        viewControllerContainerView.pinActiveAnchor(.leading, to: view)
        viewControllerContainerView.pinActiveAnchor(.trailing, to: view)
        viewControllerContainerView.pinActiveAnchor(.bottom, to: view)
        viewControllerContainerView.backgroundColor = .purple
        
        tabContainerStackView.axis = .horizontal
        tabContainerStackView.distribution = .fillEqually
        tabContainerStackView.alignment = .center
        tabContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        tabContainerStackView.pinActiveAnchor(.top, to: tabContainerView)
        tabContainerStackView.pinActiveAnchor(.bottom, to: tabContainerView)
        tabContainerStackView.pinActiveAnchor(.leading, to: tabContainerView)
        tabContainerStackView.pinActiveAnchor(.trailing, to: tabContainerView)
        
        tabBottomLineView.translatesAutoresizingMaskIntoConstraints = false
        tabBottomLineView.pinActiveAnchor(.height, constraintConstant: 1)
        tabBottomLineView.pinActiveAnchor(.leading, to: tabContainerView)
        tabBottomLineView.pinActiveAnchor(.trailing, to: tabContainerView)
        tabBottomLineView.pinActiveAnchor(.bottom, to: tabContainerView)
        tabBottomLineView.backgroundColor = .lightText
        
        tabIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        tabIndicatorView.pinActiveAnchor(.height, constraintConstant: 2)
        tabIndicatorView.pinActiveAnchor(.bottom, to: tabContainerView)
        tabIndicatorLeadingConstraint = NSLayoutConstraint(item: tabIndicatorView, attribute: .leading, relatedBy: .equal, toItem: tabContainerView, attribute: .leading, multiplier: 1, constant: 0)
        tabIndicatorLeadingConstraint?.isActive = true
        tabIndicatorView.backgroundColor = .systemPink
        
        tabContainerView.layoutIfNeeded()
        // indicator view width is determined by the container's width and the number of tabs
        let tabIndicatorWidth = (tabContainerView.frame.size.width / CGFloat(tabContainerItems.count))
        tabIndicatorView.pinActiveAnchor(.width, constraintConstant: tabIndicatorWidth)
    }

    private func configureTabItems() {
        guard tabContainerItems.count > 1, tabContainerItems.count < 6 else {
            fatalError("TabbedContainerViewController supports 2 to 5 ViewControllers")
        }
        
        viewControllers = tabContainerItems.map({ $0.viewController })

        // populate the list of tabs
        tabs = tabContainerItems.map({ $0.tabTitle }).enumerated().map({
            (index: Int, tabTitle: String) -> TabContainerTabView in
            
            let tab = TabContainerTabView.loadFromNib
            tab.configure(tabTitle: tabTitle)
            tab.delegate = self
            tab.tag = index
            return tab
        })
        tabs.forEach({ tabContainerStackView.addArrangedSubview($0) })
                
        // set first view controller as the default when the view loads
        tabs.first?.isSelected = true
        currentViewController = viewControllers.first
        
        guard let currentViewController = currentViewController,
            let currentViewControllerView = currentViewController.view else { return }
        addChild(currentViewController)
        viewControllerContainerView.addSubview(currentViewControllerView)
        currentViewControllerView.translatesAutoresizingMaskIntoConstraints = false
        currentViewControllerView.topAnchor.constraint(equalTo: viewControllerContainerView.topAnchor).isActive = true
        currentViewControllerView.bottomAnchor.constraint(equalTo: viewControllerContainerView.bottomAnchor).isActive = true
        
        // create leading and trailing constraints for the current view conroller's starting position
        currentViewControllerLeadingConstraint = NSLayoutConstraint(item: currentViewControllerView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: viewControllerContainerView,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0)
        currentViewControllerTrailingConstraint = NSLayoutConstraint(item: currentViewControllerView,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: viewControllerContainerView,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: 0)
        // layout the starting position constraints
        currentViewControllerLeadingConstraint?.isActive = true
        currentViewControllerTrailingConstraint?.isActive = true
    }
    
    // MARK: Tab Navigation
    
    private func navigateToTabIndex(_ selectedTabIndex: Int) {
        // only attempt to navigate if we're not already navigating
        // and a tab is selected that we're not currently on
        guard !isNavigating,
            currentTabIndex != selectedTabIndex else { return }
        
        isNavigating = true
        
        // update UI state for the selected tab
        tabs[currentTabIndex].isSelected = false
        tabs[selectedTabIndex].isSelected = true
        tabIndicatorLeadingConstraint?.constant = tabContainerStackView.arrangedSubviews[selectedTabIndex].frame.minX
        UIView.animate(withDuration: animationDuration, animations: {
            self.tabContainerView.layoutIfNeeded()
        })
        
        // add the new view controller selected to the container view
        currentViewController?.willMove(toParent: nil)
        newViewController = viewControllers[selectedTabIndex]
        guard let newViewController = newViewController,
            let newViewControllerView = newViewController.view else { return }
        addChild(newViewController)
        viewControllerContainerView.addSubview(newViewControllerView)
        
        // pin the top and bottom anchors of the new view controller to the container view
        newViewControllerView.translatesAutoresizingMaskIntoConstraints = false
        newViewControllerView.topAnchor.constraint(equalTo: viewControllerContainerView.topAnchor).isActive = true
        newViewControllerView.bottomAnchor.constraint(equalTo: viewControllerContainerView.bottomAnchor).isActive = true

        // determine the starting position for the new view controller
        // based on if the new tab selected is to the right or left of the current tab
        var leadingTrailingConstraintConstant: CGFloat = 0
        let containerWidth = viewControllerContainerView.frame.size.width
        if currentTabIndex < selectedTabIndex { // moving to the right
            leadingTrailingConstraintConstant = containerWidth
        } else if currentTabIndex > selectedTabIndex { // moving to the left
            leadingTrailingConstraintConstant = -containerWidth
        }

        // create leading and trailing constraints for the starting position
        let leadingConstraint = NSLayoutConstraint(item: newViewControllerView,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: viewControllerContainerView,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: leadingTrailingConstraintConstant)
        let trailingConstraint = NSLayoutConstraint(item: newViewControllerView,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: viewControllerContainerView,
                                                    attribute: .trailing,
                                                    multiplier: 1.0,
                                                    constant: leadingTrailingConstraintConstant)
        
        // layout the starting position constraints
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        viewControllerContainerView.layoutIfNeeded()

        // animate the new view controller to its ending position.
        // set leading and trailing constraints to 0 so the new view controller
        // is pinned on all sides to the container view
        UIView.transition(with: viewControllerContainerView, duration: animationDuration, options: .curveLinear, animations: {
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
            self.currentViewControllerLeadingConstraint?.constant = -leadingTrailingConstraintConstant
            self.currentViewControllerTrailingConstraint?.constant = -leadingTrailingConstraintConstant

            self.viewControllerContainerView.layoutIfNeeded()
        }, completion: { _ in
            // remove the current view controller from the parent and superview
            // set the current view controller as the new view controller
            // since the animation has completed
            self.currentViewController?.removeFromParent()
            self.currentViewController?.view.removeFromSuperview()
            self.currentViewController = newViewController
            self.currentViewControllerLeadingConstraint = leadingConstraint
            self.currentViewControllerTrailingConstraint = trailingConstraint
            self.newViewController = nil
            self.currentTabIndex = selectedTabIndex
            self.isNavigating = false
            newViewController.didMove(toParent: self)
        })
    }
    
}

// MARK: - TabbedContainerTabViewDelegate

extension TabbedContainerViewController: TabbedContainerTabViewDelegate {
    
    public func didSelectTab(_ sender: TabContainerTabView) {
        var shouldNavigate = true
        
        if let currentViewController = currentViewController as? TabbedContainerNavigationListening {
            shouldNavigate = currentViewController.tabbedContainer(self, shouldNavigateFrom: currentTabIndex, to: sender.tag)
        }
        
        if shouldNavigate {
            navigateToTabIndex(sender.tag)
        }
    }

}

// MARK: - TabbedContainerViewControllerNavigating

extension TabbedContainerViewController: TabbedContainerViewControllerNavigating {
    
    public func tabbedContainerDidSelectNextController() {
        guard currentTabIndex + 1 < tabs.count else { return }
        navigateToTabIndex(currentTabIndex + 1)
    }
    
    public func tabbedContainerDidSelectPreviousController() {
        guard currentTabIndex - 1 >= 0 else { return }
        navigateToTabIndex(currentTabIndex - 1)
    }
    
}

// MARK: - TabbedContainerViewControllerNavigating Declaration

public protocol TabbedContainerViewControllerNavigating: class {
    func tabbedContainerDidSelectNextController()
    func tabbedContainerDidSelectPreviousController()
}

// MARK: - TabbedContainerNavigationListening Declaration

public protocol TabbedContainerNavigationListening: class {
    func tabbedContainer(_ tabbedContainerViewController: TabbedContainerViewController, willNavigateFrom currentTabIndex: Int, to tabIndex: Int)
    func tabbedContainer(_ tabbedContainerViewController: TabbedContainerViewController, shouldNavigateFrom currentTabIndex: Int, to tabIndex: Int) -> Bool
}

public extension TabbedContainerNavigationListening {
    
    func tabbedContainer(_ tabbedContainerViewController: TabbedContainerViewController, willNavigateFrom currentTabIndex: Int, to tabIndex: Int) {
        
    }
    
    func tabbedContainer(_ tabbedContainerViewController: TabbedContainerViewController, shouldNavigateFrom currentTabIndex: Int, to tabIndex: Int) -> Bool {
        return true
    }
    
}
