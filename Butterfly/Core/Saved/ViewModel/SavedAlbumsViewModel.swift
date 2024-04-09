//
//  SavedAlbumsViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 1/12/24.
//

import Foundation

class SavedAlbumsViewModel: ObservableObject {
    //private var user: User
    @Published var user: User
    @Published var savedPosts = [Post]()
    
    init(user: User) {
        self.user = user
        Task {try await fetchSavedPosts(uid: user.id)}
    }
    
    @MainActor
    func fetchSavedPosts(uid: String) async throws {
        self.savedPosts = try await PostService.fetchSavedPosts(uid: uid)
    }
    

}
