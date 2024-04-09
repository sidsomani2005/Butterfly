//
//  NotificationsViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.
//

import Foundation

@MainActor
class NotificationsViewModel: ObservableObject {
    
    @Published var notifications = [Notification]()
    
    //we have changed this from private to public so that I can access in NotificationsView to call the delete method when a notification is deleted
    let service: NotificationService
    
    
    init(service: NotificationService) {
        self.service = service
        
        Task {await fetchNotifications()}
    }

    
    func fetchNotifications() async {
        //self.notifications = DeveloperPreview.shared.notifications
        do {
            self.notifications = try await service.fetchNotifications()
            try await updateNotifications()
        } catch {
            print("DEBUG: FAILED TO FETCH NOTIFICATIONS - \(error.localizedDescription)")
        }
    }
    
    
    private func updateNotifications() async throws {
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
             
            notification.user = try await UserService.fetchUser(withUid: notification.notificationSenderUid)
            
            if let postId = notification.postId {
                notification.post = try await PostService.fetchPost(postId)
            }
            
            notifications[i] = notification
        }
    }
    
    
    func deleteNotification(at indexSet: IndexSet) async {
        do {
            for index in indexSet {
                let notification = notifications[index]
                try await service.deleteNotification(notification)
                notifications.remove(at: index)
            }
        } catch {
            print("DEBUG: Failed to delete notification - \(error.localizedDescription)")
        }
    }
    
    func checkIfRequestAccepted() async throws {
        //self.notification.requestAccepted = try await NotificationService.checkIfRequestAccepted()
    }
    
}
