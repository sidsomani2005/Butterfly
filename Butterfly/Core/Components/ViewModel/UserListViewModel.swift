//
//  UserListViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/10/23.


import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    
    
    init() {
        print("DEBUG: Did init...")
    }

    
    func fetchUsers(forConfig config: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
            print("DEBUG: Failed to fetch users with error: \(error.localizedDescription)")
        }
    }
}
 
