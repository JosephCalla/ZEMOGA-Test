//
//  MoveSceneDIContainer.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import UIKit
import SwiftUI

import UIKit
import SwiftUI

final class PostsSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var postsQueriesStorage: PostsQueriesStorage = CoreDataPostsQueriesStorage(maxStorageLimit: 10)
    lazy var postsResponseCache: PostsResponseStorage = CoreDataPostsResponseStorage()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeSearchPostsUseCase() -> SearchPostsUseCase {
        return DefaultSearchPostsUseCase(postsRepository: makePostsRepository(),
                                          postsQueriesRepository: makePostsQueriesRepository())
    }
    
    func makeFetchRecentPostQueriesUseCase(requestValue: FetchRecentPostQueriesUseCase.RequestValue,
                                            completion: @escaping (FetchRecentPostQueriesUseCase.ResultValue) -> Void) -> UseCase {
        return FetchRecentPostQueriesUseCase(requestValue: requestValue,
                                              completion: completion,
                                              postsQueriesRepository: makePostsQueriesRepository()
        )
    }
    
    // Step 1
    func makeFetchPostsUseCase() -> FetchPostsUseCase {
        return DefaultFetchPostsUseCase(postsRepository: makePostsRepository())
    }
    
    func makeFetchCommentsUseCase() -> FetchCommentsUseCase {
        return DefaultFetchCommentsUseCase(postsRepository: makePostsRepository())
    }
    
    func makeFetchUsersUseCase() -> FetchUsersUseCase {
        return DefaultFetchUsersUseCase(usersRepository: makeUsersRepository())
    }
    
    // MARK: - Repositories
    func makePostsRepository() -> PostsRepository {
        return DefaultPostsRepository(dataTransferService: dependencies.apiDataTransferService, cache: postsResponseCache)
    }
    func makePostsQueriesRepository() -> PostsQueriesRepository {
        return DefaultPostsQueriesRepository(dataTransferService: dependencies.apiDataTransferService,
                                              postsQueriesPersistentStorage: postsQueriesStorage)
    }
    
    func makePosterImagesRepository() -> PosterImagesRepository {
        return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService)
    }
    
    func makeUsersRepository() -> UsersRepository {
        return DefaultUsersRepository(dataTransferService: dependencies.apiDataTransferService,
                                      cache: postsResponseCache)
    }
    
    // MARK: - Posts List
    // Inject to ViewController
    
    // Step 3
    func makePostsListViewController(actions: PostsListViewModelActions) -> PostsListViewController {
        return PostsListViewController.create(with: makePostsListViewModel(actions: actions),
                                               posterImagesRepository: makePosterImagesRepository())
    }
    
    // Prepare ViewModel Step 2
    func makePostsListViewModel(actions: PostsListViewModelActions) -> PostsListViewModel {
        return DefaultPostsListViewModel(searchPostsUseCase: makeSearchPostsUseCase(),
                                         fetchPostsUseCase: makeFetchPostsUseCase(),
                                         fetchUsersUseCase: makeFetchUsersUseCase(),
                                         actions: actions)
    }
    
    
    // MARK: - Post Details
    func makePostsDetailsViewController(post: Post, user: User) -> PostDetailsViewController {
        return PostDetailsViewController.create(with: makePostsDetailsViewModel(post: post,
                                                                                user: user))
    }
    
    func makePostsDetailsViewModel(post: Post, user: User) -> PostDetailsViewModel {
        return DefaultPostDetailsViewModel(post: post,
                                           user: user,
                                           fetchCommentsUseCase: makeFetchCommentsUseCase())
    }
    
    // MARK: - Posts Queries Suggestions List
    func makePostsQueriesSuggestionsListViewController(didSelect: @escaping PostsQueryListViewModelDidSelectAction) -> UIViewController {
        if #available(iOS 13.0, *) { // SwiftUI
            let view = PostsQueryListView(viewModelWrapper: makePostsQueryListViewModelWrapper(didSelect: didSelect))
            return UIHostingController(rootView: view)
        } else { // UIKit
            return PostsQueriesTableViewController.create(with: makePostsQueryListViewModel(didSelect: didSelect))
        }
    }
    
    func makePostsQueryListViewModel(didSelect: @escaping PostsQueryListViewModelDidSelectAction) -> PostsQueryListViewModel {
        return DefaultPostsQueryListViewModel(numberOfQueriesToShow: 10,
                                              fetchRecentPostQueriesUseCaseFactory: makeFetchRecentPostQueriesUseCase,
                                               didSelect: didSelect)
    }

    @available(iOS 13.0, *)
    func makePostsQueryListViewModelWrapper(didSelect: @escaping PostsQueryListViewModelDidSelectAction) -> PostsQueryListViewModelWrapper {
        return PostsQueryListViewModelWrapper(viewModel: makePostsQueryListViewModel(didSelect: didSelect))
    }

    // MARK: - Flow Coordinators
    func makePostsSearchFlowCoordinator(navigationController: UINavigationController) -> PostsSearchFlowCoordinator {
        return PostsSearchFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension PostsSceneDIContainer: PostsSearchFlowCoordinatorDependencies {}
