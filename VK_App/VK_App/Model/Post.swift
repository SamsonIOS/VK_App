// Post.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Post
struct Post {
    let content: String
    let dateString: String
    let imageNames: [String]
    let viewsCount = (1 ... 999).randomElement()
    let user: User
}
