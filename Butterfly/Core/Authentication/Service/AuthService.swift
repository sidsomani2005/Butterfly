//
//  AuthService.swift
//  Butterfly
//
//  Created by Sid Somani on 11/25/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase



class AuthService: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        //self.userSession = Auth.auth().currentUser
        
        Task {try await loadUserData()}
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        } catch {
            print("FAILED TO LOG IN -> DEBUG THE FOLLOWING ERROR: \(error.localizedDescription)")
        }
    }
    
    
    //THIS FUNCTION HAS NO ERROR BUT IT DOESN'T NAVIGATE TO THE FEEDVIEW SCREEN WHEN THE ACCOUNT IS CREATED
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
//        print("Email is \(email)")
//        print("Password is \(password)")
//        print("Username is \(username)")
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            //print("Did create user...")
            await uploadUserData(uid: result.user.uid, username: username, email: email)
            //print("Did upload user data...")
        } catch {
            print("FAILED TO REGISTER -> DEBUG THE FOLLOWING ERROR: \(error.localizedDescription)")
        }

    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = self.userSession?.uid else {return}
        try await UserService.shared.fetchCurrentUser()
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.currentUser = nil
    }
    
    
    private func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        UserService.shared.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {return}
        try? await FirebaseConstants.UsersCollection.document(user.id).setData(encodedUser)
    }
    
}
