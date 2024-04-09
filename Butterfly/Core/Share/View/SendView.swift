//
//  SendView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/14/24.
//

import SwiftUI
import Kingfisher

struct SendView: View {
    
    @State var user: User
    var post: Post
    
    init(user: User, post: Post) {
        self.user = user
        self.post = post
    }
    
    var body: some View {
        VStack {
            Text("Share to ") +
            
            Text("\(user.username)")
                .fontWeight(.semibold)
            
            VStack{
                KFImage(URL(string: post.imageUrls[0]))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipShape(.rect(cornerRadius: 5))
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
                
                Text(post.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 5)
            
            
            Button {
                Task {try await shareAlbum(uid: user.id, post: post)}
                //print("Shared")
            } label: {
                HStack {
                    Spacer()
                    Text("Share")
                        .padding(.vertical, 10)
                    Spacer()
                }
                .foregroundStyle(Color.white)
                .background(Color(.systemBlue))
                .clipShape(.rect(cornerRadius: 10))
                .padding(5)
            }
        }
        .padding()
        .background(Color.black)
        .foregroundStyle(.white)
        .ignoresSafeArea()
    }
    
    
    func shareAlbum(uid: String, post: Post) async throws {
        let postCopy = post
        NotificationManager.shared.shareAlbumNotificaton(toUid: uid, post: postCopy)
    }
    
    
}


#Preview {
    SendView(user: User.MOCK_USERS[0], post: Post.MOCK_POSTS[0])
}
