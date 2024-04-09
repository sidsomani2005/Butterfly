//
//  Constants.swift
//  Butterfly
//
//  Created by Sid Somani on 12/8/23.
//

import Foundation
import Firebase

struct FirebaseConstants {
    static let Root = Firestore.firestore()
    
    static let UsersCollection = Root.collection("users")
    
    static let PostsCollection = Root.collection("posts")
    
    static let FollowingCollection = Root.collection("following")
    
    static let FollowersCollection = Root.collection("followers")
    
    static let NotificationCollection = Root.collection("notifications")
    
    static func UserNotificationsCollection(uid: String) -> CollectionReference {
        return NotificationCollection.document(uid).collection("user-notifications")
    }
    
    static let UpdatesCollection = Root.collection("updates")
    
    static func SavedPostsCollection(uid: String) -> CollectionReference {
        return UsersCollection.document(uid).collection("user-saved")
    }
    
}
