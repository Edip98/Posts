//
//  UIViewController+Ext.swift
//  Posts
//
//  Created by Эдип on 17.07.2022.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction], tintColor: UIColor?, titleSize: CGFloat, titleWeight: UIFont.Weight, messageSize: CGFloat, messageWeight: UIFont.Weight) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.view.tintColor = tintColor
        
        for action in actions {
            alert.addAction(action)
        }
        
        guard let alertTitle = alert.title, let alertMessage = alert.message else { return }
        let titleString = NSAttributedString(string: alertTitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleSize, weight: titleWeight)])
        let messageString = NSAttributedString(string: alertMessage, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: messageSize, weight: messageWeight)])
        
        alert.setValue(titleString, forKey: "attributedTitle")
        alert.setValue(messageString, forKey: "attributedMessage")
        
        self.present(alert, animated: true)
    }
}
