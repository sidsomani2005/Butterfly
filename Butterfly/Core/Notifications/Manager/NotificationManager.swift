//
//  NotificationManager.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.
//

import Foundation


class NotificationManager {
    
    static let shared = NotificationManager()
    private let service = NotificationService()
    
    private init() {}
    
    func uploadLikeNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .like, post: post)
    }
    
    func uploadCommentNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .comment, post: post)

    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotification(toUid: uid, type: .follow)

    }
    
    func requestAccessNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .requestAccess, post: post)
    }
    
    func shareAlbumNotificaton(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .share, post: post)
    }
}
