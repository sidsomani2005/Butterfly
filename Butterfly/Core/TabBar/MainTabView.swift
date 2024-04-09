//
//  MainTabView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/23/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainTabView: View {
    let user: User
    @State private var selectedIndex = 0
    
    init(user: User) {
        UITabBar.appearance().barTintColor = .black // Set tab bar background color
        UITabBar.appearance().unselectedItemTintColor = .lightGray // Set unselected item color
        self.user = user
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
//            WorldFeedView()
//                .onAppear {
//                    selectedIndex = 0
//                }
//                .tabItem {
//                    Image(systemName: "globe")
//                }.tag(0)
//            
            FeedView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "person.2.fill")
                }.tag(0)
            
            SearchView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            
            UploadPostView(tabIndex: $selectedIndex)
                .onAppear {
                    selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "plus.square")
                }.tag(2)
            
            CurrentUserProfileView(user: user)
                .onAppear {
                    selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "person")
                }.tag(3)
            
        }
        .accentColor(Color(red: 0.922, green: 0.988, blue: 0.659))

        
    }
}


@available(iOS 17.0, *)
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: User.MOCK_USERS[0])
    }
}
