//
//  Comment.swift
//  Butterfly
//
//  Created by Sid Somani on 12/8/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct Comment: Identifiable, Codable {
    @DocumentID var commentId: String?
    let postOwnerUid: String
    let commentText: String
    let postId: String
    let timestamp: Timestamp
    let commentOwnerUid: String

    var user: User?
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
    
}
