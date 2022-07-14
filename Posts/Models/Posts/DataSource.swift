//
//  Post.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import Foundation

struct DataSource: Codable {
    var posts: [Posts]
}

struct Posts: Codable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
}
