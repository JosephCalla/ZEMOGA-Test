//
//  PostsSearchFlowCoordinator.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation
import UIKit

protocol PostsSearchFlowCoordinatorDependencies  {
    func makePostsListViewController(actions: PostsListViewModelActions) -> PostsListViewController
    func makePostsDetailsViewController(post: Post, user: User) -> PostDetailsViewController
    func makePostsQueriesSuggestionsListViewController(didSelect: @escaping PostsQueryListViewModelDidSelectAction) -> UIViewController
}

final class PostsSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: PostsSearchFlowCoordinatorDependencies

    private weak var postsListVC: PostsListViewController?
    private weak var postsQueriesSuggestionsVC: UIViewController?

    init(navigationController: UINavigationController,
         dependencies: PostsSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = PostsListViewModelActions(showPostDetails: showPostDetails,
                                                 showPostQueriesSuggestions: showPostQueriesSuggestions,
                                                 closePostQueriesSuggestions: closePostQueriesSuggestions)
        let vc = dependencies.makePostsListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
        postsListVC = vc
    }

    private func showPostDetails(post: Post, user: User) {
        let vc = dependencies.makePostsDetailsViewController(post: post, user: user)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showPostQueriesSuggestions(didSelect: @escaping (PostQuery) -> Void) {
//        guard let postsListViewController = postsListVC, postsQueriesSuggestionsVC == nil,
////            let container = postsListViewController.suggestionsListContainer else { return }
//
//        let vc = dependencies.makePostsQueriesSuggestionsListViewController(didSelect: didSelect)
//
//        postsListViewController.add(child: vc, container: container)
//        postsQueriesSuggestionsVC = vc
//        container.isHidden = false
    }

    private func closePostQueriesSuggestions() {
        postsQueriesSuggestionsVC?.remove()
        postsQueriesSuggestionsVC = nil
//        postsListVC?.suggestionsListContainer.isHidden = true
    }
}
