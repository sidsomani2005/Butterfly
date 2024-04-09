////
////  UserListView.swift
////  Butterfly
////
////  Created by Sid Somani on 12/10/23.
////
//
//import SwiftUI
//
//struct UserListView: View {
//    @StateObject var viewModel = UserListViewModel()
//    @State private var searchText = ""
//    
//    private let config: UserListConfig
//    
//    init(config: UserListConfig) {
//        self.config = config
//    }
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(viewModel.users) { user in
//                    NavigationLink(value: user) {
//                        HStack {
//                            CircularProfileImageView(user: user, size: .medium)
//                            
//                            VStack(alignment: .leading) { // THIS VSTACK IS ONLY FOR ACCOUNTS - MUST MAKE A DIFFERENT ONE TO DISPLAY ALBUMS SINCE ALBUMS DONT HAVE AN ALBUM ID OR USERNAME
//                                Text(user.username)
//                                    .fontWeight(.semibold)
//                                
//                                if let fullname = user.fullname {
//                                    Text(user.fullname ?? "")
//                                        .font(.footnote)
//                                }
//                            }
//                            .foregroundStyle(.white)
//                            
//                            Spacer()
//                        }
//                        .foregroundColor(.black)
//                        .padding(.horizontal)
//                    }
//                    
//                }
//            }
//            .padding(.top)
//            .searchable(text: $searchText, prompt: "Search")
//        }
//        .task {
//            await viewModel.fetchUsers(forConfig: config)
//        }
//
//    }
//}
//
//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(config: .explore)
//    }
//}

// --------------------------------------------------------------------------------------
//import SwiftUI
//
//struct UserListView: View {
//    @StateObject var viewModel = UserListViewModel()
//    @State private var searchText = ""
//    
//    private let config: UserListConfig
//    
//    init(config: UserListConfig) {
//        self.config = config
//    }
//    
//    var users: [User] {
//        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
//    }
//    
//    
//    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(users) { user in
//                    NavigationLink(value: user) {
//                        HStack {
//                            CircularProfileImageView(user: user, size: .medium)
//                            
//                            VStack(alignment: .leading) { // THIS VSTACK IS ONLY FOR ACCOUNTS - MUST MAKE A DIFFERENT ONE TO DISPLAY ALBUMS SINCE ALBUMS DONT HAVE AN ALBUM ID OR USERNAME
//                                Text(user.username)
//                                    .fontWeight(.semibold)
//                                
//                                if let fullname = user.fullname {
//                                    Text(user.fullname ?? "")
//                                        .font(.footnote)
//                                }
//                            }
//                            .foregroundStyle(.white)
//                            
//                            Spacer()
//                        }
//                        .foregroundColor(.black)
//                        .padding(.horizontal)
//                    }
//                    
//                }
//            }
//            .padding(.top)
//            .searchable(text: $searchText, prompt: "Search")
//        }
//        .task {
//            await viewModel.fetchUsers(forConfig: config)
//        }
//
//    }
//}
//
//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(config: .explore)
//    }
//}
// --------------------------------------------------------------------------------------


import SwiftUI

struct UserListView: View {
    @StateObject var viewModel: SearchViewModel
    private let config: SearchViewModelConfig
    @State private var searchText = ""
    
    init(config: SearchViewModelConfig) {
        self.config = config
        self._viewModel = StateObject(wrappedValue: SearchViewModel(config: config))
    }
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        UserCell(user: user)
                            .padding(.leading)
                    }
                }
                
            }
            .navigationTitle(config.navigationTitle)
            .padding(.top)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
    }
}
