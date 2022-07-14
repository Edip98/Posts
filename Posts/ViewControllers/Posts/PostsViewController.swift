//
//  PostsViewController.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.navigationBarTitle
        configureTableView()
    }
    
    func configureTableView() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else { return UITableViewCell() }
        cell.configure(with: viewModel, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}
