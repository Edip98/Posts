//
//  DetailsViewModel.swift
//  Posts
//
//  Created by Эдип on 15.07.2022.
//

import Foundation

class DetailsViewModel {
    
    let navigationBarTitle = "Posts"
    let hearImageName = "heart"
    
    var pushVC = {() -> () in }
    
    var id: Int?
    var title: String?
    var text: String?
    var image: URL?
    var likes: Int?
    var date: Int?
    
    var detail: DetailsModel? {
        didSet {
            title = detail?.post.title
            text = detail?.post.text
            image = URL(string: detail?.post.postImage ?? "")
            likes = detail?.post.likesCount ?? 0
            date = detail?.post.timeshamp
            pushVC()
        }
    }
    
    func getDetails() {
        NetworkManager.shared.getPostInfo(by: id ?? 0) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let details):
                self.detail = details
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getTheFormattedDateFromUnixTime() -> String {
        let unixTime = TimeInterval(date ?? 0)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d MMMM YYYY"
        return dateFormater.string(from: date)
    }
}
