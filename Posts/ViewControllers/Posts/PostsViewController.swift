//
//  PostsViewController.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let viewModel = PostViewModel()
    private var expandedIndexSet : IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationController()
        configureTableView()
        configureActivityIndicator()
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
        viewModel.getPosts()
        viewModel.reloadList = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    @objc func sortButtonTapped(_ sender: UIBarButtonItem) {
        presentActionSheet()
    }
    
    private func presentActionSheet() {
        let byLikesAction = UIAlertAction(title: viewModel.byLikesActionTitle, style: .default, handler: { _ in
            self.viewModel.sorted(.byLikes)
        })
        let byDateAction = UIAlertAction(title: viewModel.byDateActiontitle, style: .default, handler: { _ in
            self.viewModel.sorted(.byDate)
        })
        let cancelAction = UIAlertAction(title: viewModel.cancelActionTitle, style: .cancel, handler: nil)
        
        presentAlert(title: viewModel.alertTitle, message: viewModel.alertMessage, preferredStyle: .actionSheet, actions: ([byLikesAction, byDateAction, cancelAction]), tintColor: .systemIndigo, titleSize: 18, titleWeight: .bold, messageSize: 15, messageWeight: .medium)
    }
    
    private func configureNavigationController() {
        navigationItem.title = viewModel.navigationBarTitle
        let sortButton = UIBarButtonItem(image: UIImage(named: viewModel.barButtonItemImageName), style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.rightBarButtonItem = sortButton
        navigationController?.navigationBar.tintColor = .systemIndigo
    }
    
    private func configureTableView() {
        tableView.register(PostCell.nib(), forCellReuseIdentifier: PostCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250.0
    }
    
    private func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .systemIndigo
        activityIndicator.startAnimating()
    }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell else { return UITableViewCell() }
        cell.configure(with: viewModel, indexPath: indexPath, expandedIndexSet: expandedIndexSet)
        cell.didTapExpand = { [weak self] cell in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        vc.viewModel.id = viewModel.dataSource?.posts[indexPath.row].postId ?? 0
        vc.viewModel.getDetails()
        vc.viewModel.pushVC = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
