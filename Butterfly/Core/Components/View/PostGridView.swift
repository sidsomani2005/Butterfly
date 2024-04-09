////
////  PostGridView.swift
////  Butterfly
////
////  Created by Sid Somani on 11/24/23.
////
//
//import SwiftUI
//import Kingfisher
// 
//
//@available(iOS 17.0, *)
//struct PostGridView: View {
//    
//    @StateObject var viewModel: PostGridViewModel
//    
//    
//    init(user: User) {
//        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
//    }
//    
//    private let gridItems: [GridItem] = [
//        .init(.flexible(), spacing: 1),
//        .init(.flexible(), spacing: 1),
//        .init(.flexible(), spacing: 1)
//    ]
//    
//    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
//    
//    
//  
//    var body: some View {
//        
//        LazyVGrid(columns: gridItems, spacing: 1) {
//            ForEach(viewModel.posts) { post in
//                
//                NavigationLink(destination: Group {
//                    if post.isPrivate {
//                        PrivateAlbumView(post: post)
//                    } else {
//                        AlbumPageView(post: post)
//                    }
//                    
//                }) {
//                    KFImage(URL(string: post.imageUrls[0]))
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageDimension, height: imageDimension)
//                        .clipped()
//                        .navigationBarBackButtonHidden()
//                }
//            }
//        }
//        
//    }
//}
//
//@available(iOS 17.0, *)
//struct PostGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostGridView(user: User.MOCK_USERS[0])
//    }
//}
//
//
// --------------------------------------------------------------------------------------------------------------------

import SwiftUI
import Kingfisher
 

@available(iOS 17.0, *)
struct PostGridView: View {
    
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5),
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 25
    
    private var user: User {
        return viewModel.user
    }
    

    
    var body: some View {
        
        LazyVGrid(columns: gridItems) { //, spacing: 1) {
            ForEach(viewModel.posts) { post in
                NavigationLink(destination: Group {
                    if user.isCurrentUser {
                        AlbumPageView(post: post)
                    } else {
                        if post.isPrivate {
                            let hasAccess = checkIfUserHasAccess(userToCheck: user, post: post)
                            if hasAccess {
                                AlbumPageView(post: post)
                            } else {
                                PrivateAlbumView(post: post)
                            }
                        } else {
                            AlbumPageView(post: post)
                        }
                    }
                    
                }) {
                    VStack{
                        KFImage(URL(string: post.imageUrls[0]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipShape(.rect(cornerRadius: 5))
                            .padding(.horizontal, 5)
                            .padding(.top, 5)
                        
                        Text(post.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
            
                    }
                    //.padding(2.5)
                    .padding(.bottom, 5)
                    //.padding(.horizontal, 5)
                    //.padding(10)
        
                }
            }
        }
        
    }
    

    
    func checkIfUserHasAccess(userToCheck: User, post: Post) -> Bool {
        Task {try await viewModel.fetchUsersThatHaveAccessToPost(post: post)}
        return viewModel.usersThatHaveAccess.contains(userToCheck)
    }


}

@available(iOS 17.0, *)
struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView(user: User.MOCK_USERS[0])
    }
}

