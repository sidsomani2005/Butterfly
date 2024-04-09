//
//  Notification.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.
//

import Foundation
import Firebase


struct Notification: Identifiable, Codable {
    
    let id: String
    var postId: String?
    let timestamp: Timestamp
    let notificationSenderUid: String
    let type: NotificationType
    
    var post: Post?
    var user: User?
    var requestAccepted: Bool?
    var followedBack: Bool?

}
