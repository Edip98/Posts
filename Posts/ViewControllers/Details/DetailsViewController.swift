//
//  DetailsViewController.swift
//  Posts
//
//  Created by Эдип on 15.07.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configurePostImageView()
        configureTitleLabel()
        configureTextLabel()
        configureHeartImageView()
        configureLikesLabel()
        configureDateLabel()
        contentView.backgroundColor = .clear
        activityIndicator.color = .systemIndigo
    }
    
    private func configureViewController() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.navigationBarTitle
        navigationController?.navigationBar.tintColor = .systemIndigo
    }
    
    private func configureScrollView() {
        scrollView.backgroundColor = .clear
    }
    
    private func configurePostImageView() {
        guard let url = viewModel.image else { return }
        postImageView.loadImage(from: url, indicator: activityIndicator)
        postImageView.contentMode = .scaleAspectFill
    }
    
    private func configureTitleLabel() {
        titleLabel.text = viewModel.title
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
    }
    
    private func configureTextLabel() {
        textLabel.text = viewModel.text
        textLabel.textColor = .black
        textLabel.font = .systemFont(ofSize: 17)
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
    }
    
    private func configureHeartImageView() {
        heartImageView.image = UIImage(named: viewModel.hearImageName)
        heartImageView.contentMode = .scaleToFill
    }
    
    private func configureLikesLabel() {
        likesLabel.text = decimalStyle(viewModel.likes ?? 0)
        likesLabel.textColor = .black
        likesLabel.font = .systemFont(ofSize: 16)
    }
    
    private func configureDateLabel() {
        dateLabel.text = viewModel.getTheFormattedDateFromUnixTime()
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 17)
    }
}
