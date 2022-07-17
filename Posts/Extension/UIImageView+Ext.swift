//
//  UIImageView+Ext.swift
//  Posts
//
//  Created by Эдип on 16.07.2022.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, indicator: UIActivityIndicatorView) {
        indicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        indicator.stopAnimating()
                        indicator.isHidden = true
                    }
                }
            }
        }
    }
}
