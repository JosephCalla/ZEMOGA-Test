//
//  PostsQueriesTableViewController.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import UIKit

final class PostsQueriesTableViewController: UITableViewController, StoryboardInstantiable {
    
    private var viewModel: PostsQueryListViewModel!

    // MARK: - Lifecycle

    static func create(with viewModel: PostsQueryListViewModel) -> PostsQueriesTableViewController {
        let view = PostsQueriesTableViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: PostsQueryListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    // MARK: - Private

    private func setupViews() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = PostsQueriesItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PostsQueriesTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsQueriesItemCell.reuseIdentifier, for: indexPath) as? PostsQueriesItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(PostsQueriesItemCell.self) with reuseIdentifier: \(PostsQueriesItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelect(item: viewModel.items.value[indexPath.row])
    }
}
