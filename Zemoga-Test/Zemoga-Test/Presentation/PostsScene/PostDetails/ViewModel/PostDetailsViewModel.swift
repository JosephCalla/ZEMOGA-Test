//
//  PostDetailsViewModel.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation

protocol PostDetailsViewModelInput {
//    func viewDidLoad()
}

protocol PostDetailsViewModelOutput {
    var title: String { get }
    var user: User? { get }
    var body: String { get }
    var itemComments: Observable<[CommentsListItemViewModel]> { get set }
}

protocol PostDetailsViewModel: PostDetailsViewModelInput, PostDetailsViewModelOutput { }

final class DefaultPostDetailsViewModel: PostDetailsViewModel {
    private let fetchCommentsUseCase: FetchCommentsUseCase?
    private var detailLoadTask: Cancellable? {
        willSet { detailLoadTask?.cancel() }
    }
    
    // MARK: - OUTPUT
    var itemComments: Observable<[CommentsListItemViewModel]> = Observable([])
    let title: String
    var user: User?
    let posterImage: Observable<Data?> = Observable(nil)
    let error: Observable<String> = Observable("")
    var comments: [Comment] = []
    let isPosterImageHidden: Bool
    var body: String
    
    init(post: Post,
         user: User,
         fetchCommentsUseCase: FetchCommentsUseCase) {
        self.title = post.title
        self.user = user
        self.body = post.body
        self.isPosterImageHidden = post.posterPath == nil
        self.fetchCommentsUseCase = fetchCommentsUseCase
        loadComments(by: post.id)
    }

}

// MARK: - INPUT. View event methods
extension DefaultPostDetailsViewModel {
        
    private func cachedComment(_ comments: [Comment]) { // UPDATE IT !!!
        self.comments = comments
    }
    
    
    private func loadComments(by postsID: Int) {
        detailLoadTask = fetchCommentsUseCase?.execute(
            query: CommentRequestDTO(id: postsID),
            cached: cachedComment,
            completion: { result in
                switch result {
                case .success(let comments):
                    self.itemComments.value = comments.map(CommentsListItemViewModel.init)
                case .failure(let error):
                    self.handle(error: error)
                }
                //            self.loading.value = .none
            })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        NSLocalizedString("No internet connection", comment: "") :
        NSLocalizedString("Failed loading Posts", comment: "")
    }
}

