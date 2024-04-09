//
//  ShareView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/6/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct ShareView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                ShareListView(config: .search, post: post)
//                    .navigationDestination(for: User.self, destination: { user in
//                        ProfileView(user: user)
//                    })
                    .navigationBarTitleDisplayMode(.inline)
                    .padding(.top)
                    .background(Color.black)
                    .foregroundColor(.white)
            }
            
        }

    }
}


@available(iOS 17.0, *)
#Preview {
    ShareView(post: Post.MOCK_POSTS[1])
}
