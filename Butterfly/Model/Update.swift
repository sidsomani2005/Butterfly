//
//  Update.swift
//  Butterfly
//
//  Created by Sid Somani on 12/26/23.
//

import Foundation
import Firebase


struct Update: Identifiable, Codable {
    
    let id: String
    let timestamp: Timestamp
    let uploadedUrls: [String]
    let userId: String
    let postId: String
    
    var post: Post?
    var user: User?
    
}



extension Update {
    static var MOCK_UPDATES: [Update] = [
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), uploadedUrls: ["sids_pfp", "dinosaur", "towers"], userId: NSUUID().uuidString, postId: NSUUID().uuidString, post: Post.MOCK_POSTS[0], user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), uploadedUrls: ["sids_pfp", "dinosaur", "towers"], userId: NSUUID().uuidString, postId: NSUUID().uuidString, post: Post.MOCK_POSTS[0], user: User.MOCK_USERS[0])
    ]
}
