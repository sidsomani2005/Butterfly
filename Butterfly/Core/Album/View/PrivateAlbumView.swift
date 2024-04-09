//
//  PrivateAlbumView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/16/23.
//

import SwiftUI
import Kingfisher
import UIKit


@available(iOS 17.0, *)
struct PrivateAlbumView: View {
    
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: AlbumPageViewModel
    
    private var post: Post {
        return viewModel.post
    }
    
    @State private var accessRequested = false
    
    private var buttonTitle: String {
        return accessRequested ? "Request Access" : "Requested"
    }
    
    private var buttonBackgroundColor: Color {
        if accessRequested {
            return .black
        } else {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        }
    }
    
    private var buttonForegroundColor: Color {
        if accessRequested {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        } else {
            return .black
        }
    }
    
    private var buttonBorderColor: Color {
        if accessRequested {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        } else {
            return .clear
        }
    }
    
    
//    private var hasAccess: Bool {
//        return post.hasAccess ?? false
//    }
    
    init(post: Post) {
        self.viewModel = AlbumPageViewModel(post: post)
    }

    var body: some View {
        
        ZStack {
//            Image("towers")
//                .resizable()
//                .scaledToFit()
//                .containerRelativeFrame([.horizontal, .vertical])
//                .ignoresSafeArea()
//                .blur(radius: 15)
//                .padding(.bottom, 30)
                
            
            //Image or album cover/photo
            KFImage(URL(string: post.imageUrls[0]))
                .resizable()
                .scaledToFit()
                .containerRelativeFrame([.horizontal, .vertical])
                .ignoresSafeArea()
                .blur(radius: 15)
                .padding(.bottom, 30)

    
            
            VStack {
                HStack {
                    if let user = post.user {
                        CircularProfileImageView(user: user, size: .smallMedium)
                            .padding(.top, 15)
                            .padding(.bottom, -10)
                            .padding(.leading, 10)
                            .shadow(color: Color.black, radius: 20, x: 0, y: 10)
                
                        Text(user.username)
                            .padding(.top, 20)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 10)
                
                HStack {
                    if let user = post.user {
                        Text(post.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                
                Spacer()
                
                Text("Private Album")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                
                Image(systemName: "lock.fill")
                    .resizable()
                    .frame(width: 100, height: 140)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                
                Spacer()
                Spacer()
            }

        }
        .background(Color.black)
        .toolbar {
            ToolbarItem {
                Button {
                    print("Private album access requested")
                    handleRequestAccessTapped()
                } label: {
                    Text("Request Access")
                        .fontWeight(.semibold)
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .background(buttonBackgroundColor)
                        .foregroundStyle(buttonForegroundColor)
                        //.clipShape(.rect(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(buttonBorderColor, lineWidth: 1)
                        )
                }
            }
        }
    }
    
    private func handleRequestAccessTapped() {
        Task {
            if try await viewModel.checkIfUserHasAccessToPost() {
                try await viewModel.unfollowPrivateAlbum()
                accessRequested = false
            } else {
                try await viewModel.requestAccess()
                accessRequested = true
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    PrivateAlbumView(post: Post.MOCK_POSTS[0])
}
