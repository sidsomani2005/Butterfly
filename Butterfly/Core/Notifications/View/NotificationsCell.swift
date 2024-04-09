//
//  NotificationsCell.swift
//  Butterfly
//
//  Created by Sid Somani on 12/19/23.


import SwiftUI
import Kingfisher

@available(iOS 17.0, *)
struct NotificationsCell: View {
    
    let notification: Notification
    @State private var accessRequestAccepted = false
    
    
    private var buttonTitle: String {
        return accessRequestAccepted ? "Allowing" : "Allow"
    }
    
    
    private var buttonBackgroundColor: Color {
        if accessRequestAccepted {
            return .black
        } else {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        }
    }
    
    private var buttonForegroundColor: Color {
        if accessRequestAccepted {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        } else {
            return .black
        }
    }
    
    private var buttonBorderColor: Color {
        if accessRequestAccepted {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        } else {
            return .clear
        }
    }
    
    
    
    var body: some View {
        HStack {
//            NavigationLink(value: notification.user) {
//                CircularProfileImageView(user: notification.user, size: .small)
//            }
            
            CircularProfileImageView(user: notification.user, size: .small)
            
            //Notification Message
            HStack {
                Text(notification.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
                Text(" \(notification.type.notificationMessage)")
                    .font(.subheadline) +
//                Text("\(NotificationMessage(notification: notification))")
//                    .font(.subheadline) +
                
                
                
                Text(" \(notification.timestamp.timestampString())")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        
            
            Spacer()
            
            if notification.type == .follow {
                Button {
                    print("DEBUG - HANDLE FOLLOW HERE...")
                } label: {
                    Text("Follow back")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .background(Color(red: 0.922, green: 0.988, blue: 0.659))
                        .clipShape(.rect(cornerRadius: 10))
                }
                
            } else if notification.type == .requestAccess {
                Button {
                    //print("DEBUG - GRANT ACCESS HERE...")
                    if let post = notification.post {
                        Task {try await acceptAccessRequest(uid: notification.notificationSenderUid, post: post)}
                        accessRequestAccepted = true
                    }

                } label: {
                    Text(buttonTitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 15)
                        .foregroundStyle(buttonForegroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(buttonBorderColor, lineWidth: 1)
                        )
                        .background(buttonBackgroundColor)
                        //.clipShape(.rect(cornerRadius: 5))
                }
                
            } else if notification.type == .share {
                if let post = notification.post {
                    NavigationLink(destination: AlbumPageView(post: post)) {
                        KFImage(URL(string: notification.post?.imageUrls[0] ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            
            } else {
                KFImage(URL(string: notification.post?.imageUrls[0] ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.rect(cornerRadius: 10))
            }
            
        }
        //.padding(.horizontal)
    }
    
    private func acceptAccessRequest(uid: String, post: Post) async throws {
        let postCopy = post
        try await PostService.acceptAccessRequest(uid: uid, post: postCopy)
        accessRequestAccepted = true
    }

    
}

@available(iOS 17.0, *)
#Preview {
    NotificationsCell(notification: DeveloperPreview.shared.notifications[3])
}





//
////
////  NotificationsCell.swift
////  Butterfly
////
////  Created by Sid Somani on 12/19/23.
//
//
//import SwiftUI
//import Kingfisher
//
//@available(iOS 17.0, *)
//struct NotificationsCell: View {
//    
//    var notification: Notification
//    
//    private var accessRequestAccepted: Bool {
//        return notification.requestAccepted ?? false
//    }
//    
//    private var buttonTitle: String {
//        return accessRequestAccepted ? "Allowing" : "Allow"
//    }
//    
//    
//    private var buttonBackgroundColor: Color {
//        if accessRequestAccepted {
//            return .black
//        } else {
//            return Color(red: 0.922, green: 0.988, blue: 0.659)
//        }
//    }
//    
//    private var buttonForegroundColor: Color {
//        if accessRequestAccepted {
//            return Color(red: 0.922, green: 0.988, blue: 0.659)
//        } else {
//            return .black
//        }
//    }
//    
//    private var buttonBorderColor: Color {
//        if accessRequestAccepted {
//            return Color(red: 0.922, green: 0.988, blue: 0.659)
//        } else {
//            return .clear
//        }
//    }
//    
//    
//    
//    var body: some View {
//        HStack {
////            NavigationLink(value: notification.user) {
////                CircularProfileImageView(user: notification.user, size: .small)
////            }
//            
//            CircularProfileImageView(user: notification.user, size: .small)
//            
//            //Notification Message
//            HStack {
//                Text(notification.user?.username ?? "")
//                    .font(.subheadline)
//                    .fontWeight(.semibold) +
//                
//                Text(" \(notification.type.notificationMessage)")
//                    .font(.subheadline) +
////                Text("\(NotificationMessage(notification: notification))")
////                    .font(.subheadline) +
//                
//                
//                
//                Text(" \(notification.timestamp.timestampString())")
//                    .foregroundStyle(.gray)
//                    .font(.footnote)
//            }
//        
//            
//            Spacer()
//            
//            if notification.type == .follow {
//                Button {
//                    print("DEBUG - HANDLE FOLLOW HERE...")
//                } label: {
//                    Text("Follow back")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.black)
//                        .padding(.vertical, 5)
//                        .padding(.horizontal, 15)
//                        .background(Color(red: 0.922, green: 0.988, blue: 0.659))
//                        .clipShape(.rect(cornerRadius: 10))
//                }
//            } else if notification.type == .requestAccess {
//                Button {
//                    //print("DEBUG - GRANT ACCESS HERE...")
//                    if let post = notification.post {
//                        
//                        Task {try await acceptAccessRequest(uid: notification.notificationSenderUid, post: post)}
//                    }
//
//                } label: {
//                    Text(buttonTitle)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .padding(.vertical, 5)
//                        .padding(.horizontal, 15)
//                        .foregroundStyle(buttonForegroundColor)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(buttonBorderColor, lineWidth: 1)
//                        )
//                        .background(buttonBackgroundColor)
//                        //.clipShape(.rect(cornerRadius: 5))
//                }
//            } else {
//                KFImage(URL(string: notification.post?.imageUrls[0] ?? ""))
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipShape(.rect(cornerRadius: 10))
//            }
//            
//        }
//        //.padding(.horizontal)
//    }
//    
//    private func acceptAccessRequest(uid: String, post: Post) async throws {
//        let postCopy = post
//        try await PostService.acceptAccessRequest(uid: uid, post: postCopy)
//        notification.requestAccepted = true
//    }
//
//    
//}
//
//@available(iOS 17.0, *)
//#Preview {
//    NotificationsCell(notification: DeveloperPreview.shared.notifications[3])
//}
