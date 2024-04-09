//
//  WorldFeedViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/11/23.
//

import Foundation
import Firebase


class WorldFeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task {try await fetchPosts()}
    }

    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()
    }
    
}
