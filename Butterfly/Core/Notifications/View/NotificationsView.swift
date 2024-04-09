//
//  NotificationsView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.


import SwiftUI

@available(iOS 17.0, *)
struct NotificationsView: View {
    
    @StateObject var viewModel = NotificationsViewModel(service: NotificationService())
    
    @State private var selectedIndices: IndexSet = []
    
    var body: some View {
        NavigationStack {
            
            Divider()
                .padding(.top, 10)
            
            List {
                ForEach(viewModel.notifications) { notif in
                    NotificationsCell(notification: notif)
                }
                .onDelete { indexSet in
                    deleteNotification(at: indexSet)
                }
            }
            .navigationTitle("Notifications")
            .padding(.top, 10)
            
        }
        //.background(Color.black)
        .foregroundStyle(.white)

    }
    
    private func deleteNotification(at offsets: IndexSet) {
        Task {
            for index in offsets {
                let notification = viewModel.notifications[index]
                do {
                    try await viewModel.service.deleteNotification(notification)
                    viewModel.notifications.remove(at: index)
                } catch {
                    print("DEBUG: Failed to delete notification - \(error.localizedDescription)")
                }
            }
        }
    }
    
//    func deleteNotification(at offsets: IndexSet) {
//        viewModel.notifications.remove(atOffsets: offsets)
//    }
}

@available(iOS 17.0, *)
#Preview {
    NotificationsView()
}
