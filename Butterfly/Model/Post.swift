////
////  Post.swift
////  Butterfly
////
////  Created by Sid Somani on 11/24/23.
////


import Foundation
import Firebase


struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let title: String
    let caption: String
    var likes: Int
    var comments: Int
    var numphotos: Int
    let imageUrls: [String]
    let isPrivate: Bool
    let timestamp: Timestamp
    var user: User?
    
    var didLike: Bool? = false
    var isSaved: Bool? = false
    var hasAccess: Bool? = false
    
}


extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Title 1",
            caption: "caption 1",
            likes: 123,
            comments: 100,
            numphotos: 15,
            imageUrls: ["sids_pfp"],
            isPrivate: true,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Title 2",
            caption: "caption 2",
            likes: 133,
            comments: 110,
            numphotos: 25,
            imageUrls: ["sids_pfp"],
            isPrivate: false,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Title 3",
            caption: "caption 3.2",
            likes: 144,
            comments: 121,
            numphotos: 36,
            imageUrls: ["butterfly_logo"],
            isPrivate: false,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Title 4",
            caption: "caption 3",
            likes: 143,
            comments: 120,
            numphotos: 35,
            imageUrls: ["sids_pfp"],
            isPrivate: false,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[2]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Title 5",
            caption: "caption 4",
            likes: 153,
            comments: 130,
            numphotos: 45,
            imageUrls: ["sids_pfp"],
            isPrivate: false,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[3]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Title 6",
            caption: "caption 5",
            likes: 163,
            comments: 140,
            numphotos: 55,
            imageUrls: ["sids_pfp"],
            isPrivate: false,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[4]
        )
    ]
}


extension Post {
    static var MOCK_SAVED_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            title: "Saved Post 1",
            caption: "Saved post caption 1",
            likes: 123,
            comments: 100,
            numphotos: 15,
            imageUrls: ["sids_pfp"],
            isPrivate: true,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0]
        )
    ]
}

