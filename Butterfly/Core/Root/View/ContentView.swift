//
//  ContentView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/23/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    
    
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()

    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
            }
        }

    } 

}


@available(iOS 17.0, *)
#Preview {
    ContentView()
}
