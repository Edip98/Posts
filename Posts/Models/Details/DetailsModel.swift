//
//  DetailsModel.swift
//  Posts
//
//  Created by Эдип on 16.07.2022.
//

import Foundation

struct DetailsModel: Decodable {
    let post: Post
}

struct Post: Decodable {
    let postID: Int
    let timeshamp: Int
    let title, text: String
    let postImage: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
