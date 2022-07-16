//
//  DetailsViewModel.swift
//  Posts
//
//  Created by Эдип on 15.07.2022.
//

import Foundation

class DetailsViewModel {
    
    let navigationBarTitle = "Posts"
    let heartEmoji = "❤️"

    var title: String?
    var text: String?
    var likes: String?
    var date: Int?
    
    var post: Posts? {
        didSet {
            title = post?.title
            text = post?.previewText
            likes = "\(heartEmoji) \(post?.likesCount ?? 0)"
            date = post?.timeshamp
        }
    }
    
    func getTheFormattedDate() -> String {
        let unixTime = TimeInterval(post?.timeshamp ?? 0)
        let date = Date(timeIntervalSince1970: unixTime)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
