//
//  LoginViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 11/26/23.
//

import Foundation


class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
