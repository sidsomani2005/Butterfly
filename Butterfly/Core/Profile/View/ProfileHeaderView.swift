//
//  ProfileHeaderView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false
    
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var stats: UserStats {
        return user.stats ?? .init(followingCount: 0, followersCount: 0, postsCount: 0)
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    private var buttonBackgroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        }
    }
    
    private var buttonForegroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        } else {
            return .black
        }
    }
    
    private var buttonBorderColor: Color {
        if user.isCurrentUser || isFollowed {
            return Color(red: 0.922, green: 0.988, blue: 0.659)
        } else {
            return .clear
            
        }
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            //pfp + bio
            HStack {
                //name + bio
                VStack(alignment: .leading, spacing: 4) {
                    
                    if let fullname = user.fullname {
                        Text(fullname)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                    }
                    
                    
                    Text("@"+user.username)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    if let bio = user.bio {
                        Text(bio)
                            .font(.footnote)
                    }
                    
                    //Text(user.username)
                    
                     
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                CircularProfileImageView(user: user, size: .xlarge)
                    .padding(.trailing)
                
            }
            
            //stats
            HStack {
                HStack {
                    Text("\(stats.postsCount)")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Text("Pictures Shared")
                        .font(.footnote)
                }
                .opacity(stats.postsCount == 0 ? 0.5 : 1.0)
                .frame(width: 140)

                NavigationLink(value: UserListConfig.following(uid: user.id)) {
                    UserStatView(value: stats.followingCount, title: "Following")
                }
                
                NavigationLink(value: UserListConfig.followers(uid: user.id)) {
                    UserStatView(value: stats.followersCount, title: "Followers")
                }
                

            }
            
        
            
            //action button
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    handleFollowTapped()
                    //print("Follow user...")
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .foregroundColor(buttonForegroundColor)
                    .background(buttonBackgroundColor)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(buttonBorderColor, lineWidth: 1)
                    )
            }
            
            
            Divider()
            
        }
        .background(Color.black)
        .foregroundColor(.white)
//        .navigationDestination(for: UserListConfig.self, destination: { config in
//            UserListView(config: config )
//        })
        .onAppear {
            viewModel.fetchUserStats()
            viewModel.checkIfUserIsFollowed() 
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
        
    }
    
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.MOCK_USERS[0])
    }
}
