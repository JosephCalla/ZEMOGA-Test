//
//  CommentsListItemCell.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 6/02/23.
//

import Foundation
import UIKit

final class CommentsListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CommentsListItemCell.self)
//    static let height = CGFloat(60)
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private var viewModel: CommentsListItemViewModel!
    private var posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    func fill(with viewModel: CommentsListItemViewModel) {
        self.viewModel = viewModel
        nameLabel.text = "\(viewModel.name)"
        emailLabel.text = "\(viewModel.email)"
        bodyLabel.text = "\(viewModel.body)"
    }
}
