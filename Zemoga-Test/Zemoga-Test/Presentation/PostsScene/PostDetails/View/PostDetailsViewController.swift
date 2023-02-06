//
//  PostDetailsViewController.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import UIKit

final class PostDetailsViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var overviewTextView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Lifecycle

    private var viewModel: PostDetailsViewModel!
    private var delegate: UITableViewDelegate?
    
    static func create(with viewModel: PostDetailsViewModel) -> PostDetailsViewController {
        let view = PostDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupViews()
        bind(to: viewModel)
//        viewModel.
    }

    private func bind(to viewModel: PostDetailsViewModel) {
        viewModel.itemComments.observe(on: self) { [weak self] _ in self?.updateItems() }
    }
    
    private func updateItems() {
        tableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Private

    private func setupViews() {
        title = viewModel.title
        posterImageView.layer.cornerRadius = 10
        self.authorLabel.text = viewModel.user?.name
        self.overviewTextView.text = viewModel.body
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PostDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.itemComments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentsListItemCell.reuseIdentifier,
                                                       for: indexPath) as? CommentsListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(CommentsListItemCell.self) with reuseIdentifier: \(CommentsListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }

        cell.fill(with: viewModel.itemComments.value[indexPath.row])

        return cell
    }
}

