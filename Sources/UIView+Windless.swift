//
//  UIView+Windless.swift
//  Windless-iOS
//
//  Created by gwangbeom on 2017. 11. 8..
//  Copyright © 2017년 Windless. All rights reserved.
//

import UIKit

public extension UIView {
    
    private struct AssociatedKeys {
        static var isWindlessable = "isWindlessableKey"
        static var windless = "windlessKey"
        static var showing = "showingKey"
    }
    
    /**
     Whether the view is visible in the loading view state
     If it is false, the view is not visible in the loading view. Default true
     */
    @IBInspectable var isShow: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.showing) as? Bool ?? true }
        set { objc_setAssociatedObject(self, &AssociatedKeys.showing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /**
     **isWindlessable** allows the view to be composed of skeletons.
     If true, the view becomes the skeleton of the loading view and is exposed to the animation. Default false
     */
    @IBInspectable var isWindlessable: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.isWindlessable) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.isWindlessable, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    /**
     **windless** makes subviews with a true isWindlessable value of true as a loading view with a skeleton and helps control the animation.
     */
    var windless: Windless {
        guard let windless = objc_getAssociatedObject(self, &AssociatedKeys.windless) as? Windless else {
            let windless = Windless(contentsView: self)
            objc_setAssociatedObject(self, &AssociatedKeys.windless, windless, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return windless
        }
        return windless
    }
    
    internal var allSubviews: [UIView] {
        return [self] + subviews.flatMap { $0.allSubviews }
    }
}
