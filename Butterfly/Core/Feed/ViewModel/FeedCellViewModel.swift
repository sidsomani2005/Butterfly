//
//  FeedCellViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/3/23.
//

import Foundation

@MainActor
class FeedCellViewModel: ObservableObject {
    @Published var update: Update
    
    init(update: Update) {
        self.update = update
    }
    
//    func shareAlbum(uid: String, post: Post) async throws {
//        let postCopy = post
//        NotificationManager.shared.shareAlbumNotificaton(toUid: uid, post: postCopy)
//    }
//    
}
