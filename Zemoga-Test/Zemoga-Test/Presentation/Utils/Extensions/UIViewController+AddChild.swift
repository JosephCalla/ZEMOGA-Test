//
//  UIViewController+AddChild.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
