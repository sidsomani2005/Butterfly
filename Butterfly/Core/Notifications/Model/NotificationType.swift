//
//  NotificationType.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.
//

import Foundation


enum NotificationType: Int, Codable {
    case like
    case comment
    case follow
    case requestAccess
    case share
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked one of your posts."
        case .comment: return "commented on one of your posts."
        case .follow: return "started following you."
        case .requestAccess: return "has requestion to view"//return "has requested to view an album."
        case .share: return "shared an album"
        }
    }
    
}
