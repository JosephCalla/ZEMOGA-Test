//
//  AppFlowCoordinator .swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let postsSceneDIContainer = appDIContainer.makePostsSceneDIContainer()
        let flow = postsSceneDIContainer.makePostsSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
