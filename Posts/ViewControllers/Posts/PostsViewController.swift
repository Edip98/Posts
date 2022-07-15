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
    var expandedIndexSet : IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.navigationBarTitle
        configureTableView()
    }
    
    func configureTableView() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250.0
    }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else { return UITableViewCell() }
        
        cell.configure(with: viewModel, indexPath: indexPath, expandedIndexSet: expandedIndexSet)
        cell.buttonClicked = { [weak self] cell in
            guard let self = self else { return }

            if self.expandedIndexSet.contains(indexPath.row){
                self.expandedIndexSet.remove(indexPath.row)
            } else {
                self.expandedIndexSet.insert(indexPath.row)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
}
