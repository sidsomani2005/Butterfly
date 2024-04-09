//
//  UpdateService.swift
//  Butterfly
//
//  Created by Sid Somani on 12/26/23.
//

import Foundation
import Firebase


struct UpdateService {
    
    private static let updatesCollection = FirebaseConstants.UpdatesCollection

    static func fetchUpdates() async throws -> [Update] {
        do {
            let snapshot = try await updatesCollection.getDocuments()
            var updates = try snapshot.documents.compactMap({ document in
                let update = try document.data(as: Update.self)
                return update
            })

            for i in 0 ..< updates.count {
//                if (updates[i].user.isFollowed) {
//                    
//                }
                let update = updates[i]
                let updateOriginator = try await UserService.fetchUser(withUid: update.userId)
                let updatedAlbum = try await PostService.fetchPost(update.postId)
                updates[i].user = updateOriginator
                updates[i].post = updatedAlbum
            }
            
            return updates
            
        } catch {
            print("Error fetching feed posts: \(error)")
            print("Localized Description: \(error.localizedDescription)")
            throw error
        }
    }

    
    
    static func fetchUpdate(_ updateId: String) async throws -> Update {
        let snapshot = try await updatesCollection.document(updateId).getDocument(as: Update.self)
        return snapshot
    }
    
}


