//
//  UIView+Extensions.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 08/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit

public extension UIView {
    
    func pinActiveAnchor(_ anchorType: AnchorType, to view: UIView? = nil, constraintConstant: CGFloat = 0) {
        switch anchorType {
        case .height:
            self.heightAnchor.constraint(equalToConstant: constraintConstant).isActive = true
        case .width:
            self.widthAnchor.constraint(equalToConstant: constraintConstant).isActive = true
        case .top:
            guard let view = view else { return }
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constraintConstant).isActive = true
        case .bottom:
            guard let view = view else { return }
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constraintConstant).isActive = true
        case .leading:
            guard let view = view else { return }
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintConstant).isActive = true
        case .trailing:
            guard let view = view else { return }
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constraintConstant).isActive = true
        case .centerVertical:
            guard let view = view else { return }
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constraintConstant).isActive = true
        case .centerHorizontal:
            guard let view = view else { return }
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constraintConstant).isActive = true
        }
    }
    
    func addSubviewEdgeToEdge(_ subview: UIView?) {
        guard let subview = subview else { return }
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.pinActiveAnchor(.leading, to: self)
        subview.pinActiveAnchor(.trailing, to: self)
        subview.pinActiveAnchor(.top, to: self)
        subview.pinActiveAnchor(.bottom, to: self)
    }
    
    func addSubviewCentered(_ subview: UIView?) {
        guard let subview = subview else { return }
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.pinActiveAnchor(.centerHorizontal, to: self)
        subview.pinActiveAnchor(.centerVertical, to: self)
    }

}

public enum AnchorType {
    case height
    case width
    case top
    case bottom
    case leading
    case trailing
    case centerVertical
    case centerHorizontal
}
