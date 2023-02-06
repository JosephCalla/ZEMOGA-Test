//
//  PostsQueryListView.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension PostsQueryListItemViewModel: Identifiable { }

@available(iOS 13.0, *)
struct PostsQueryListView: View {
    @ObservedObject var viewModelWrapper: PostsQueryListViewModelWrapper
    
    var body: some View {
        List(viewModelWrapper.items) { item in
            Button(action: {
                self.viewModelWrapper.viewModel?.didSelect(item: item)
            }) {
                Text(item.query)
            }
        }
        .onAppear {
            self.viewModelWrapper.viewModel?.viewWillAppear()
        }
    }
}

@available(iOS 13.0, *)
final class PostsQueryListViewModelWrapper: ObservableObject {
    var viewModel: PostsQueryListViewModel?
    @Published var items: [PostsQueryListItemViewModel] = []
    
    init(viewModel: PostsQueryListViewModel?) {
        self.viewModel = viewModel
        viewModel?.items.observe(on: self) { [weak self] values in self?.items = values }
    }
}

#if DEBUG
@available(iOS 13.0, *)
struct PostsQueryListView_Previews: PreviewProvider {
    static var previews: some View {
        PostsQueryListView(viewModelWrapper: previewViewModelWrapper)
    }
    
    static var previewViewModelWrapper: PostsQueryListViewModelWrapper = {
        var viewModel = PostsQueryListViewModelWrapper(viewModel: nil)
        viewModel.items = [PostsQueryListItemViewModel(query: "item 1"),
                           PostsQueryListItemViewModel(query: "item 2")
        ]
        return viewModel
    }()
}
#endif
