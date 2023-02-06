//
//  PostsQueriesItemCell.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import UIKit

final class PostsQueriesItemCell: UITableViewCell {
    static let height = CGFloat(50)
    static let reuseIdentifier = String(describing: PostsQueriesItemCell.self)

    @IBOutlet private var titleLabel: UILabel!
    
    func fill(with suggestion: PostsQueryListItemViewModel) {
        self.titleLabel.text = suggestion.query
    }
}
