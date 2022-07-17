//
//  PostViewModel.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import Foundation

class PostViewModel {
    
    var dataSource: PoststsModel?
    
    let navigationBarTitle = "Posts"
    let expandButtonText = "Expand"
    let collapseButtonText = "Collapse"
    let heartEmoji = "❤️"
    
     init() {
        getPosts()
    }
    
    private func getPosts() {
        NetworkManager.shared.getPost { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.dataSource = posts
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getTheFormattedDate(at indexpath: IndexPath) -> String {
        let unixTime = TimeInterval(dataSource?.posts[indexpath.row].timeshamp ?? 0)
        let date = Date(timeIntervalSince1970: unixTime)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
