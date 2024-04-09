//
//  NotificationServicee.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.
//

import Foundation
import Firebase
import FirebaseAuth

class NotificationService {
    
    
    func fetchNotifications() async throws -> [Notification] {
        guard let currentUid = Auth.auth().currentUser?.uid else {return []}
        
        let snapshot = try await FirebaseConstants
            .UserNotificationsCollection(uid: currentUid)
            .getDocuments()

        return snapshot.documents.compactMap({ try? $0.data(as: Notification.self) })
    }
    
    
    func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else {return}
        //let ref = FirebaseConstants.UserNotificationsCollection(uid: currentUid).document()
        let ref = FirebaseConstants.UserNotificationsCollection(uid: uid).document()

        
        let notification = Notification(
            id: ref.documentID,
            postId: post?.id,
            timestamp: Timestamp(),
            notificationSenderUid: currentUid,
            type: type
        )
        
        guard let notificationData = try? Firestore.Encoder().encode(notification) else {return}
        
        ref.setData(notificationData)
    }
    
    func deleteNotification(_ notification: Notification) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await FirebaseConstants.UserNotificationsCollection(uid: uid).document(notification.id).delete()
    }
    
//    static func checkIfRequestAccepted(_ notification: Notification) async throws -> Bool {
//        
//        let snapshot = try await FirebaseConstants.NotificationCollection.document(notification.id).document(notification.requestAccepted).getDocument()
//        
//        return snapshot
//    }
//    
    
}
