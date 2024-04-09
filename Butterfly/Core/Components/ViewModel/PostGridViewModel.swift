//
//  PostGridViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/3/23.
//

import Foundation

class PostGridViewModel: ObservableObject {
    //private var user: User
    @Published var user: User
    @Published var posts = [Post]()
    @Published var usersThatHaveAccess = [User]()
    
    init(user: User) {
        self.user = user
        
        Task {try await fetchUserPosts()}
        
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
            
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
    
    @MainActor
    func fetchUsersThatHaveAccessToPost(post: Post) async throws {
        self.usersThatHaveAccess = try await PostService.fetchUsersThatHaveAccess(post: post)
    }
    
}
