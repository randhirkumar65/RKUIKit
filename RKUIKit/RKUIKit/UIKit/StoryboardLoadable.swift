//
//  StoryboardLoadable.swift
//  RKUIKit
//
//  Created by Randhir Kumar on 08/09/20.
//  Copyright © 2020 Randhir kumar. All rights reserved.
//

import UIKit

public protocol StoryboardLoadable: class {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
}

public extension StoryboardLoadable {
    
    static var storyboardName: String {
        return String(describing: self.self)
    }
    
    static var storyboardBundle: Bundle {
        return Bundle(for: self.self)
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: storyboardBundle)
    }
    
}

public extension StoryboardLoadable where Self: UIViewController {

    static func fromStoryboard(named customStoryboardName: String? = nil, in bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: customStoryboardName ?? storyboardName, bundle: bundle ?? storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardName) as! Self
    }

    static var fromStoryboard: Self {
        return storyboard.instantiateViewController(withIdentifier: storyboardName) as! Self
    }

}
