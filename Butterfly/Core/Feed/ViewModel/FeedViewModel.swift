//
//  FeedViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/3/23.
//

import Foundation
import Firebase


class FeedViewModel: ObservableObject {
    @Published var updates = [Update]()
    
    init() {
        Task {try await fetchUpdates()}
    }

    @MainActor
    func fetchUpdates() async throws {
        self.updates = try await UpdateService.fetchUpdates()
    }
    
}
