//
//  ShareViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 1/6/24.
//

import Foundation


@MainActor
class ShareViewModel: ObservableObject {
    @Published var users = [User]()
    
    
    init() {
        print("DEBUG: Did init...")
    }

    
    //NEED FUNCTION TO FETCH CURRENT USER'S FOLLOWERS INSTEAD OF ALL USERS
    
    func fetchUsers(forConfig config: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
            print("DEBUG: Failed to fetch users with error: \(error.localizedDescription)")
        }
    }
}
 
