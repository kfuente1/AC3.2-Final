//
//  Post.swift
//  AC3.2-Final
//
//  Created by Karen Fuentes on 2/15/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

class Post {
    let key: String
    let userId: String
    let comment: String
    init(key: String, userId: String, comment: String) {
        self.key = key
        self.userId = userId
        self.comment = comment
    }
    var asDictionary: [String: String] {
        return ["userId": userId,
                "comment": comment]
    }
}
