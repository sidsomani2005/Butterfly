//
//  CommentService.swift
//  Butterfly
//
//  Created by Sid Somani on 12/8/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct CommentService {
    
    let postId: String
    
    func uploadComment(_ comment: Comment) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else {return}
        
        try await FirebaseConstants.PostsCollection.document(postId).collection("post-comments").addDocument(data: commentData)
    }
    
    func fetchComments() async throws -> [Comment] {
        let snapshot = try await Firestore
            .firestore()
            .collection("posts")
            .document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return try snapshot.documents.compactMap({ comment in
            let comment = try comment.data(as: Comment.self)
            return comment
        })
    }
}



