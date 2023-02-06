//
//  PostsListViewModel.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation

struct PostsListViewModelActions {
    /// Note: if you would need to edit Post inside Details screen and update this Posts List screen with updated Post then you would need this closure:
    /// showPostDetails: (Post, @escaping (_ updated: Post) -> Void) -> Void
    let showPostDetails: (Post, User) -> Void
    let showPostQueriesSuggestions: (@escaping (_ didSelect: PostQuery) -> Void) -> Void
    let closePostQueriesSuggestions: () -> Void
}

enum PostsListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol PostsListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
}

protocol PostsListViewModelOutput {
    var items: Observable<[PostsListItemViewModel]> { get } /// Also we can calculate view model items on demand:  https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/pull/10/files
    var loading: Observable<PostsListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

protocol PostsListViewModel: PostsListViewModelInput, PostsListViewModelOutput {}

final class DefaultPostsListViewModel: PostsListViewModel {

    private let searchPostsUseCase: SearchPostsUseCase?
    private let actions: PostsListViewModelActions?
    private let fetchPostsUseCase: FetchPostsUseCase?
    private let fetchUsersUseCase: FetchUsersUseCase?
    
    var currentPage: Int = 0
    private var PostsLoadTask: Cancellable? { willSet { PostsLoadTask?.cancel() } }
    private var posts: [Post] = [] // DATA SOURCE TO USE
    private var users: [User] = []
    // MARK: - OUTPUT

    let items: Observable<[PostsListItemViewModel]> = Observable([])
    let loading: Observable<PostsListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Posts", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Posts", comment: "")

    // MARK: - Init

    init(searchPostsUseCase: SearchPostsUseCase? = nil,
         fetchPostsUseCase: FetchPostsUseCase? = nil,
         fetchUsersUseCase: FetchUsersUseCase? = nil,
         actions: PostsListViewModelActions? = nil) {
        self.searchPostsUseCase = searchPostsUseCase
        self.fetchPostsUseCase = fetchPostsUseCase
        self.fetchUsersUseCase = fetchUsersUseCase
        self.actions = actions
    }

    // MARK: - Private

    private func resetPages() {
        items.value.removeAll()
    }

    private func load(PostQuery: PostQuery, loading: PostsListViewModelLoading) {
    }
    
    // Temporary
    private func cachedPost(_ posts: [Post]) { // UPDATE IT !!!
        self.posts = posts
    }
    
    private func cachedUsers(_ users: [User]) { // UPDATE IT !!!
        self.users = users
    }
    
    // Ready to show to tableview
    private func load() {
        PostsLoadTask = fetchPostsUseCase?.execute(cached: cachedPost, completion: { result in
            switch result {
            case .success(let posts):
                self.posts = posts
                self.items.value = posts.map(PostsListItemViewModel.init)
                self.loadUsers()
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
        })
    }
    
    private func loadUsers() {
        PostsLoadTask = fetchUsersUseCase?.execute(cached: cachedUsers, completion: { result in
            switch result {
            case .success(let users):
//                self.posts = posts
                self.users = users
//                self.items.value = posts.map(PostsListItemViewModel.init)
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
        })

    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading Posts", comment: "")
    }

    private func update(PostQuery: PostQuery) {
        resetPages()
        load(PostQuery: PostQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultPostsListViewModel {

    func viewDidLoad() {
        load()
//        loadUsers()
    }

    func didLoadNextPage() {
//        guard hasMorePages, loading.value == .none else { return }
//        load(PostQuery: .init(query: query.value),
//             loading: .nextPage)
    }

    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(PostQuery: PostQuery(query: query))
    }

    func didCancelSearch() {
        PostsLoadTask?.cancel()
    }

    func showQueriesSuggestions() {
        actions?.showPostQueriesSuggestions(update(PostQuery:))
    }

    func closeQueriesSuggestions() {
        actions?.closePostQueriesSuggestions()
    }

    func didSelectItem(at index: Int) {
        if let user = users.first(where: { $0.id == index }) {
            actions?.showPostDetails(posts[index], user )
        }
    }
}

// MARK: - Private
