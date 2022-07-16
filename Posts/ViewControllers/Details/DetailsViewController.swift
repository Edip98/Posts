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
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = viewModel.navigationBarTitle
        contentView.backgroundColor = .clear
        configureScrollView()
        configurePostImageView()
        configureTitleLabel()
        configureTextLabel()
        configureLikesLabel()
        configureDateLabel()
    }
    
    func configureScrollView() {
        scrollView.backgroundColor = .clear
    }
    
    func configurePostImageView() {
        postImageView.contentMode = .scaleAspectFill
    }
    
    func configureTitleLabel() {
        titleLabel.text = viewModel.title
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.sizeToFit()
    }
    
    func configureTextLabel() {
        textLabel.text = viewModel.text
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
    }
    
    func configureLikesLabel() {
        likesLabel.text = viewModel.likes
        likesLabel.textColor = .black
    }
    
    func configureDateLabel() {
        dateLabel.text = viewModel.getTheFormattedDate()
        dateLabel.textColor = .black
    }
}

