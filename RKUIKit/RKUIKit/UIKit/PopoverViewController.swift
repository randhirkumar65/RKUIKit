//
//  PopoverViewController.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 07/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    /// An instance of this class presents a viewcontroller as popover for compact environments(Phone).
    final class PopOverController: NSObject, UIPopoverPresentationControllerDelegate {
        override init() {
            super.init()
        }

        func adaptivePresentationStyle(for _: UIPresentationController, traitCollection _: UITraitCollection) -> UIModalPresentationStyle {
            return .none
        }
    }

    struct PopoverContentSize {
        static let width: CGFloat = 350.0
        static let height: CGFloat = 155.0
    }

    private var contentSize: CGSize
    private let popoverController: PopOverController
    private var cornerRadius: CGFloat?

    /// Show Native tooltip as a popover.
    /// - Parameters:
    ///   - sourceView: Pass sourceview which will give anchor location for the popover
    ///   - permittedArrowDirections: Pass arrow direction (default .any) for your popover e.g down,up,any etc.
    ///   - contentSize: Pass preferredContentSize (default width 343.0,height 152.0) for popoverviewcontroller
    ///   - cornerRadius: Pass corner radius (default 0) for popoverviewcontroller
    init(with sourceView: UIView,
         permittedArrowDirections: UIPopoverArrowDirection = .any,
         contentSize: CGSize = CGSize(width: PopoverContentSize.width, height: PopoverContentSize.height),
         cornerRadius: CGFloat? = 0.0) {
        self.contentSize = contentSize
        popoverController = PopOverController()
        self.cornerRadius = cornerRadius
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .popover
        preferredContentSize = contentSize
        guard let popover = popoverPresentationController else {
            assertionFailure("no popover presentation controller")
            return
        }
        popover.permittedArrowDirections = permittedArrowDirections
        popover.delegate = popoverController
        popover.backgroundColor = .gray
        popover.sourceView = sourceView
        popover.sourceRect = sourceView.bounds
    }

    /// customizable popover background color if needed.
    /// set it before presenting the viewController.
    /// background color defaults to ``` UIColor.moveSlate ``` if not set explicitly.
    public var backgroundColor: UIColor {
        set {
            popoverPresentationController?.backgroundColor = newValue
        } get {
            return popoverPresentationController?.backgroundColor ?? UIColor.gray
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.superview?.layer.cornerRadius = cornerRadius ?? 0
    }
}
