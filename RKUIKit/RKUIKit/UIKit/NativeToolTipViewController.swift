//
//  NativeToolTipViewController.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 07/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//


import UIKit

public struct NativeToolTipViewDimension {
    public struct View {
        static let horizontalOffset: CGFloat = 12 // TipView leading/trailing offset
        static let verticalOffset: CGFloat = 20
        
        /// Returns height needed for the view, given a attributed text
        /// - Parameters:
        ///   - attributedText: attributed text to accomodate
        ///   - font: font of the text
        ///   - width: available width
        static func getAttributedTextHeight(for attributedText: NSAttributedString, font: UIFont, width: CGFloat) -> CGFloat {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.attributedText = attributedText
            label.sizeToFit()
            return label.frame.height
        }
    }
}

/// Show Native tooltip as a popover.
public class NativeToolTipViewController: PopoverViewController {
    private enum Constant {
        static let titleLabelHeightConstant: CGFloat = 21.0
        static let titleLabelTopConstant: CGFloat = 8.0
        static let bodyLabelTopConstant: CGFloat = 10.0
        static let cornerRadius: CGFloat = 4.0
        static let labelPadding: CGFloat = 8.0 // Label's padding to tooltip
        static let titleFont: UIFont = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        static let regularBodyFont: UIFont = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        static let boldBodyFont: UIFont = UIFont.systemFont(ofSize: 11.0, weight: .bold)
        static let bodyLineSpacing: CGFloat = 16.0
        static let titleLineSpacing: CGFloat = 20.0
    }

    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var bodyLabel: UILabel?
    @IBOutlet private weak var titleLabelHeightConstraint: NSLayoutConstraint?
    @IBOutlet private weak var titleLabelTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var bodyLabelTopConstraint: NSLayoutConstraint?

    private var titleAttributedText: NSAttributedString? {
        get {
            return titleLabel?.attributedText
        }
        set {
            guard let title = titleLabel else { return }
            title.isHidden = false
            titleLabelHeightConstraint?.constant = Constant.titleLabelHeightConstant
            titleLabelTopConstraint?.constant = Constant.titleLabelTopConstant
            bodyLabelTopConstraint?.constant = Constant.bodyLabelTopConstant
            titleLabel?.attributedText = newValue
        }
    }

    private var bodyAttributedText: NSAttributedString? {
        get {
            return bodyLabel?.attributedText
        }
        set {
            bodyLabel?.attributedText = newValue
        }
    }

    public var titleFont: UIFont {
        return Constant.titleFont
    }

    public var bodyFont: UIFont {
        return Constant.regularBodyFont
    }

    public var bodyFontBold: UIFont {
        return Constant.boldBodyFont
    }

    override init(with sourceView: UIView,
                  permittedArrowDirections _: UIPopoverArrowDirection = .any,
                  contentSize _: CGSize = CGSize(width: PopoverContentSize.width, height: PopoverContentSize.height),
                  cornerRadius _: CGFloat? = 0.0) {
        super.init(with: sourceView, permittedArrowDirections: .any, contentSize: CGSize.zero, cornerRadius: Constant.cornerRadius)
    }

    public init(with sourceView: UIView) {
        super.init(with: sourceView, permittedArrowDirections: .any, contentSize: CGSize.zero, cornerRadius: Constant.cornerRadius)
        // Background color of tooltip
        backgroundColor = view.backgroundColor ?? UIColor.gray
    }

    /// Set title text
    /// - Parameter titleText: string to set for title
    public func setTitleText(with titleText: String?) {
        // Title text
        titleAttributedText = getAttributedStringForTitleText(titleText: titleText)
    }

    /// Given a localized string, this returns an attributed strings with default attributes defined for the body text for tooltip.
    /// - Parameter bodyText: text to be shown in body of tooltip
    public func getAttributedStringForTitleText(titleText: String?) -> NSMutableAttributedString? {
        guard let titleText = titleText else {
            return nil
        }

        // Get attributed body text to show
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = Constant.titleLineSpacing
        paragraphStyle.maximumLineHeight = Constant.titleLineSpacing

        // Set font size of the body text
        let attributedString = NSMutableAttributedString(string: titleText, attributes: [
            .font: titleFont,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ])

        return attributedString
    }

    /// Set body text on toolip
    /// - Parameter text: normal localized string
    public func setBodyText(with text: String?) {
        bodyAttributedText = getAttributedStringForBodyText(bodyText: text)
    }

    /// Set body text for tooltip
    /// - Parameter attributedString: attributed string to set for body
    public func setBodyText(with attributedString: NSMutableAttributedString?) {
        // Body text
        bodyAttributedText = attributedString
    }

    /// Given a localized string, this returns an attributed strings with default attributes defined for the body text for tooltip.
    /// - Parameter bodyText: text to be shown in body of tooltip
    public func getAttributedStringForBodyText(bodyText: String?) -> NSMutableAttributedString? {
        guard let bodyText = bodyText else {
            return nil
        }

        // Get attributed body text to show
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = Constant.bodyLineSpacing
        paragraphStyle.maximumLineHeight = Constant.bodyLineSpacing

        // Set font size of the body text
        let attributedString = NSMutableAttributedString(string: bodyText, attributes: [
            .font: Constant.regularBodyFont,
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ])

        return attributedString
    }

    /// Updates the size of tooltip based on title text, body text and available width
    /// - Parameter toolTipOccupiedWith: available width for tooltip
    public func updateToolTipSize(toolTipOccupiedWith: CGFloat) {
        // This is the allowed space for text. We need to substract the padding for label inside the tooltip
        let tipViewAvailableTextWidth = toolTipOccupiedWith - 2 * Constant.labelPadding

        // Height of the tooltip view is combined of title and body text.
        var tipViewHeight: CGFloat = 0.0
        // If title present, include the height
        if let titleAttributedText = titleAttributedText {
            tipViewHeight += NativeToolTipViewDimension.View.getAttributedTextHeight(for: titleAttributedText, font: titleFont, width: tipViewAvailableTextWidth)
                + (2 * NativeToolTipViewDimension.View.verticalOffset)
        }
        // If body text present, include the height
        if let bodyAttributedText = bodyAttributedText {
            tipViewHeight += NativeToolTipViewDimension.View.getAttributedTextHeight(for: bodyAttributedText, font: bodyFont, width: tipViewAvailableTextWidth)
        }

        // Set content size
        preferredContentSize = CGSize(width: tipViewAvailableTextWidth, height: tipViewHeight)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func hideTitle(_ state: Bool) {
        titleLabel?.isHidden = state
        titleLabelHeightConstraint?.constant = 0
        titleLabelTopConstraint?.constant = 0
    }
}
