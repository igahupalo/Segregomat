//
//  Navigation+Ext.swift
//  Segregomat
//
//  Created by Iga Hupalo on 28/06/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        standardAppearance.titleTextAttributes = [.font : UIFont(name: "Rubik-Medium", size: 12)!]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.titleTextAttributes = [.font : UIFont(name: "Rubik-Medium", size: 12)!]

        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.configureWithTransparentBackground()
        compactAppearance.titleTextAttributes = [.font : UIFont(name: "Rubik-Medium", size: 12)!]

        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        navigationBar.compactAppearance = compactAppearance

        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
