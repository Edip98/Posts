//
//  PostViewModel.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import Foundation

enum Sort {
    case byLikes, byDate
}

class PostViewModel {
    
    let navigationBarTitle = "Posts"
    let expandButtonText = "Expand"
    let collapseButtonText = "Collapse"
    let hearImageName = "heart"
    let barButtonItemImageName = "SortDescending"
    let alertTitle = "Sort by"
    let alertMessage = "The posts will be sorted in descending order."
    let byLikesActionTitle = "Likes"
    let byDateActiontitle = "Date"
    let cancelActionTitle = "Cancel"
    
    var reloadList = {() -> () in }
    var sortedByLikes: [Posts]?
    var sortedByDate: [Posts]?
    
    var dataSource: PoststsModel? {
        didSet {
            reloadList()
        }
    }
    
    func getPosts() {
        NetworkManager.shared.getPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.dataSource = posts
                self.sortedByLikes = posts.posts.sorted(by: { $0.likesCount > $1.likesCount})
                self.sortedByDate = posts.posts.sorted(by: { $0.timeshamp < $1.timeshamp})
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func sorted(_ sort: Sort) {
        switch sort {
        case .byLikes:
            self.dataSource?.posts = self.sortedByLikes ?? []
        case .byDate:
            self.dataSource?.posts = self.sortedByDate ?? []
        }
    }
    
    func getTheFormattedDate(at indexPath: IndexPath) -> String {
        let unixTime = TimeInterval(dataSource?.posts[indexPath.row].timeshamp ?? 0)
        let date = Date(timeIntervalSince1970: unixTime)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
