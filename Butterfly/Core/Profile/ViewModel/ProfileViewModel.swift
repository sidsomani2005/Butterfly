//
//  ProfileViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/9/23.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        print("DEBUG: Did init...")
        self.user = user
    }
    
    func fetchUserStats() {
        guard user.stats == nil else {return}
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
    
}

//MARK: - FOLLOWING ---------------

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        guard user.stats == nil else {return}
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
    
}
