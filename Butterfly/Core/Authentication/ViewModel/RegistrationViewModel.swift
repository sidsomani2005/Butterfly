//
//  RegistrationViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 11/25/23.
//

import Foundation

@MainActor
class RegistrationViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
    
}

