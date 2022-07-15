//
//  PostCell.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    static let identifier = "PostCell"
    var isButtonPressed = false
    
    var buttonClicked: ((PostCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureTitleLabel()
        configureDetailLabel()
        configureLikeslabel()
        configureDateLabel()
        configureButton()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PostCell", bundle: nil)
    }
  
    
    func configure(with viewModel: PostViewModel, indexPath: IndexPath, expandedIndexSet: IndexSet ) {
        titleLabel.text = viewModel.dataSource?.posts[indexPath.row].title
        detailLabel.text = viewModel.dataSource?.posts[indexPath.row].previewText
        likesLabel.text = "\(viewModel.heartEmoji) \(viewModel.dataSource?.posts[indexPath.row].likesCount ?? 0)"
        dateLabel.text = viewModel.getTheFormattedDate(at: indexPath)
        expandButton.setTitle(viewModel.expandButtonText, for: .normal)
        
        if expandedIndexSet.contains(indexPath.row) {
            expandButton.setTitle(viewModel.collapseButtonText, for: .normal)
            detailLabel.numberOfLines = 0
        } else {
            expandButton.setTitle(viewModel.expandButtonText, for: .normal)
            detailLabel.numberOfLines = 2
        }
    }
    
    @IBAction func expandButtonTapped(_ sender: UIButton) {
        buttonClicked?(self)
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configureTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.font = .boldSystemFont(ofSize: 16)
    }
    
    func configureDetailLabel() {
        detailLabel.textColor = .black
        detailLabel.numberOfLines = 2
        detailLabel.lineBreakMode = .byTruncatingTail
    }
    
    func configureLikeslabel() {
        likesLabel.textColor = .secondaryLabel
    }
    
    func configureDateLabel() {
        dateLabel.textColor = .secondaryLabel
    }
    
    func configureButton() {
        expandButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        expandButton.backgroundColor = .systemIndigo
        expandButton.setTitleColor(.white, for: .normal)
        expandButton.layer.cornerRadius = 12
    }
}
