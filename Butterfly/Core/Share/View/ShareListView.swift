//
//  ShareListView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/6/24.
//

import SwiftUI

struct ShareListView: View {
    @StateObject var viewModel: SearchViewModel
    private let config: SearchViewModelConfig
    @State private var searchText = ""
    @State var showSendButton = false
    
    @State var selectedUser: User?
    @State var post: Post

    
    init(config: SearchViewModelConfig, post: Post) {
        self.config = config
        self._viewModel = StateObject(wrappedValue: SearchViewModel(config: config))
        self.post = post
    }
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5),
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 40
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(users) { user in
                    NavigationLink (destination: SendView(user: user, post: post)) {
                        VStack {
                            CircularProfileImageGridView(user: user)
                                .frame(width: imageDimension, height: imageDimension)
                            Text(user.username)
                                .font(.footnote)
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 5)
                        .padding(.top, 5)
//                        .onTapGesture {
//                            selectedUser = user
//                            showSendButton.toggle()
//                        }
                    }
                }
                
            }
            .navigationTitle(config.navigationTitle)
            .padding(.top)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
//        .sheet(isPresented: $showSendButton) {
//            if let userToSend = selectedUser {
//                SendView(user: userToSend, post: post)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 5)
//                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
//            }
//
//        }
    }
}



