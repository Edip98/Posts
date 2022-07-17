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
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    static let identifier = "PostCell"
    var didTapExpand: ((PostCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureTitleLabel()
        configureDetailLabel()
        configureHeartImageView()
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
        likeImageView.image = UIImage(named: viewModel.hearImageName)
        likesLabel.text = NumberFormatterStyle.decimalStyle(viewModel.dataSource?.posts[indexPath.row].likesCount ?? 0)
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
        didTapExpand?(self)
    }
    
    private func configureCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    private func configureDetailLabel() {
        detailLabel.textColor = .black
        detailLabel.lineBreakMode = .byTruncatingTail
        detailLabel.font = .systemFont(ofSize: 17)
    }
    
    private func configureHeartImageView() {
        likeImageView.contentMode = .scaleToFill
    }
    
    private func configureLikeslabel() {
        likesLabel.textColor = .black
        likesLabel.textColor = .black
        likesLabel.font = .systemFont(ofSize: 16)
    }
    
    private func configureDateLabel() {
        dateLabel.textColor = .black
        dateLabel.textColor = .systemGray
        dateLabel.font = .systemFont(ofSize: 17)
    }
    
    private func configureButton() {
        expandButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        expandButton.backgroundColor = .systemIndigo
        expandButton.setTitleColor(.white, for: .normal)
        expandButton.layer.cornerRadius = 12
    }
}
