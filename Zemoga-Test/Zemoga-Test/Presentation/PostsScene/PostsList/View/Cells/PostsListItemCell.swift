//
//  PostsListItemCell.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation
import UIKit

final class PostsListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: PostsListItemCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }

    private var viewModel: PostsListItemViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    func fill(with viewModel: PostsListItemViewModel, posterImagesRepository: PosterImagesRepository?) {
        self.viewModel = viewModel
        self.posterImagesRepository = posterImagesRepository

        titleLabel.text = "Title: \(viewModel.title)"
        
    }
}
