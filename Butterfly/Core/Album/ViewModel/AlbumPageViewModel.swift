//
//  AlbumPageViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/13/23.
//

import Foundation


@MainActor
class AlbumPageViewModel: ObservableObject {
    //@Published var post: Post
    var post: Post
    
    init(post: Post) {
        self.post = post
        Task {try await checkIfUserLikedPost()}
    }
    
    
    func like() async throws {
        do {
            let postCopy = post
            post.didLike = true
            post.likes += 1
            try await PostService.likePost(postCopy)
            NotificationManager.shared.uploadLikeNotification(toUid: post.ownerUid, post: post)
        } catch {
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            let postCopy = post
            post.didLike = false
            post.likes -= 1
            try await PostService.unlikePost(postCopy)
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikedPost() async throws {
        self.post.didLike = try await PostService.checkIfUserLikedPost(post)
    }
    
    
    
    
    func requestAccess() async throws {
        print(post.ownerUid)
        NotificationManager.shared.requestAccessNotification(toUid: post.ownerUid, post: post)
    }
    
    func unfollowPrivateAlbum() async throws {
        let postCopy = post
        try await PostService.unfollowPrivateAlbum(postCopy)
    }
    
    func checkIfUserHasAccessToPost() async throws -> Bool {
        //self.post.hasAccess = try await PostService.checkIfUserHasAccess(post)
        return try await PostService.checkIfUserHasAccess(post)
    }
    
    
    func shareAlbum() async throws {
        let postCopy = post
        NotificationManager.shared.shareAlbumNotificaton(toUid: postCopy.ownerUid, post: postCopy)
    }
    
    
    
    func save() async throws {
        do {
            let postCopy = post
            post.isSaved = true
            try await PostService.savePost(postCopy)
        } catch {
            post.isSaved = false
        }
    }
    
    func unsave() async throws {
        do {
            let postCopy = post
            post.isSaved = false
            try await PostService.unsavePost(postCopy)
        } catch {
            post.isSaved = true
        }
    }
}
