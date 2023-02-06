//
//  PostsQueryListViewModel.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation

typealias PostsQueryListViewModelDidSelectAction = (PostQuery) -> Void

protocol PostsQueryListViewModelInput {
    func viewWillAppear()
    func didSelect(item: PostsQueryListItemViewModel)
}

protocol PostsQueryListViewModelOutput {
    var items: Observable<[PostsQueryListItemViewModel]> { get }
}

protocol PostsQueryListViewModel: PostsQueryListViewModelInput, PostsQueryListViewModelOutput { }

typealias FetchRecentPostQueriesUseCaseFactory = (
    FetchRecentPostQueriesUseCase.RequestValue,
    @escaping (FetchRecentPostQueriesUseCase.ResultValue) -> Void
    ) -> UseCase

final class DefaultPostsQueryListViewModel: PostsQueryListViewModel {

    private let numberOfQueriesToShow: Int
    private let fetchRecentPostQueriesUseCaseFactory: FetchRecentPostQueriesUseCaseFactory
    private let didSelect: PostsQueryListViewModelDidSelectAction?
    
    // MARK: - OUTPUT
    let items: Observable<[PostsQueryListItemViewModel]> = Observable([])
    
    init(numberOfQueriesToShow: Int,
         fetchRecentPostQueriesUseCaseFactory: @escaping FetchRecentPostQueriesUseCaseFactory,
         didSelect: PostsQueryListViewModelDidSelectAction? = nil) {
        self.numberOfQueriesToShow = numberOfQueriesToShow
        self.fetchRecentPostQueriesUseCaseFactory = fetchRecentPostQueriesUseCaseFactory
        self.didSelect = didSelect
    }
    
    private func updatePostsQueries() {
        let request = FetchRecentPostQueriesUseCase.RequestValue(maxCount: numberOfQueriesToShow)
        let completion: (FetchRecentPostQueriesUseCase.ResultValue) -> Void = { result in
            switch result {
            case .success(let items):
                self.items.value = items.map { $0.query }.map(PostsQueryListItemViewModel.init)
            case .failure: break
            }
        }
        let useCase = fetchRecentPostQueriesUseCaseFactory(request, completion)
        useCase.start()
    }
}

// MARK: - INPUT. View event methods
extension DefaultPostsQueryListViewModel {
        
    func viewWillAppear() {
        updatePostsQueries()
    }
    
    func didSelect(item: PostsQueryListItemViewModel) {
        didSelect?(PostQuery(query: item.query))
    }
}
