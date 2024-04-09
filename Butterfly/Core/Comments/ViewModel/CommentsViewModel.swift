//
//  CommentsViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/8/23.
//

import Foundation
import Firebase

@MainActor
class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    private let post: Post
    private let service: CommentService
    
    init(post: Post) {
        self.post = post
        self.service = CommentService(postId: post.id)
        
        Task {try await fetchComments() }
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let comment = Comment(postOwnerUid: post.ownerUid, commentText: commentText, postId: post.id, timestamp: Timestamp(), commentOwnerUid: uid)
        
//        self.comments.insert(comment, at: 0)
//        self.comments[0].user = UserService.shared.currentUser
        try await service.uploadComment(comment)
        try await fetchComments()
        
        NotificationManager.shared.uploadCommentNotification(toUid: post.ownerUid, post: post)
    }
     
    
    func fetchComments() async throws {
        self.comments = try await service.fetchComments()
        try await fetchUserDataForComments()
    }
    
    
    private func fetchUserDataForComments() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOwnerUid)
            comments[i].user = user
        }
    }
}
 
