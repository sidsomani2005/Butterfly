//
//  User.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import Foundation
import Firebase

struct User: Identifiable, Codable, Hashable {
    let id: String 
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

struct UserStats: Codable, Hashable {
    var followingCount: Int
    var followersCount: Int
    var postsCount: Int
}


extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "sidsomani", profileImageUrl: nil, fullname: "Sid Somani", bio: "Im a cool kid.", email: "sidsomani2005@gmail.com"),
        .init(id: NSUUID().uuidString, username: "suhith_k", profileImageUrl: nil, fullname: "Suhith Kanneganti", bio: "Im Sid's BP.", email: "sk@gmail.com"),
        .init(id: NSUUID().uuidString, username: "aarushSahoo", profileImageUrl: nil, fullname: "Aarush Sahoo", bio: "Im an og trio.", email: "as@gmail.com"),
        .init(id: NSUUID().uuidString, username: "r_chibber", profileImageUrl: nil, fullname: "Rahul Chib", bio: "Im an og trio.", email: "rc@gmail.com"),
        .init(id: NSUUID().uuidString, username: "arish_virani", profileImageUrl: nil, fullname: "Arish Virani", bio: "Im Sid's roommate.", email: "av@gmail.com")
    ]
}



