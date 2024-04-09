//
//  CommentsView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/6/23.
//

import SwiftUI

struct CommentsView: View {
    
    @State private var commentText = ""
    @StateObject var viewModel: CommentsViewModel
    
    private var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: CommentsViewModel(post: post))
    }
    
    var body: some View {
        VStack {
            Text("Comments")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.top, 25)
            
            Divider()
            
            ScrollView {
                LazyVStack (spacing: 25) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }
            .padding(.top)
            
            Divider()
            
            HStack (spacing: 10) {
                CircularProfileImageView(user: currentUser, size: .small)
                    .padding(.leading, 10)
                
                ZStack (alignment: .trailing) {
                    TextField("Add a comment", text: $commentText, axis: .vertical)
                        .font(.footnote)
                        .padding(10)
                        .padding(.horizontal, 5)
                        .overlay {
                            Capsule()
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        }
                    
                }
                
                Button{
                    Task {
                        try await viewModel.uploadComment(commentText: commentText)
                        commentText = ""
                    }
                    //print("comment posted !")
                } label: {
                    Image(systemName: "arrow.up")
                        .frame(width: 35, height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())

                }
                
            }
            .padding()
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(post: Post.MOCK_POSTS[0])
    }
}
