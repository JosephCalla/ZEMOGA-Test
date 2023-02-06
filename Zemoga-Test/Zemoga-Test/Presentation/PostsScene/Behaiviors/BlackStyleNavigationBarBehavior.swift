//
//  BlackStyleNavigationBarBehavior.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation
import UIKit

struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationController?.navigationBar.barStyle = .black
    }
}
