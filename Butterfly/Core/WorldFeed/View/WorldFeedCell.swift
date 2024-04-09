//
//  WorldFeedView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/11/23.
//

import SwiftUI
import Kingfisher

@available(iOS 17.0, *)
struct WorldFeedCell: View {
    
    @ObservedObject var viewModel: WorldFeedCellViewModel
    
    @State private var showComments = false;
    @State private var showActionSheet = false;
    
    private var post: Post {
        return viewModel.post
    }
    
    private var didLike: Bool {
        return post.didLike ?? false
    }
    
    init(post: Post) {
        self.viewModel = WorldFeedCellViewModel(post: post)
    }
    
    
    var body: some View {
        //need to set background color or something to show that its all ONE post or cell or album
        ZStack {
//            Image("towers")
//                .resizable()
//                .scaledToFill()
//                .containerRelativeFrame([.horizontal, .vertical])
//                .ignoresSafeArea()
//                .padding(.bottom, 30)
                
            
//            Image or album cover/photo
            KFImage(URL(string: post.imageUrls[0]))
                .resizable()
                .scaledToFit()
                .containerRelativeFrame([.horizontal, .vertical])
                .ignoresSafeArea()

    
            
            VStack {
                HStack {
                    
                    if let user = post.user {
                        NavigationLink(destination: ProfileView(user: user)) {
                            CircularProfileImageView(user: user, size: .small)
                                .padding(.top, 15)
                                .padding(.bottom, -10)
                                .padding(.leading, 10)
                                .shadow(color: Color.black, radius: 20, x: 0, y: 10)
                    
                            Text(user.username)
                                .padding(.top, 20)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        showActionSheet = true
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .frame(width: 30, height: 6)
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .padding(.trailing)
                            .padding(.top, 30)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                    }
                }
                .padding(.top, 50)
                .padding(.leading, 10)
                
                HStack {
                    if let user = post.user {
                        NavigationLink(destination: AlbumPageView(post: post)) {
                            Text(post.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.leading, 10)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                        }
                    }
                    
                    Spacer()
                    

                }
                .padding(.top, 10)
                .padding(.leading, 10)
                
                Spacer()
                
                //HStack for likes, photos, bookmark, sharing
                VStack {
                    HStack(spacing: 15) {
                        Button {
                            handleLikeTapped()
                            //print("Album LIKED")
                        } label: {
                            Image(systemName: didLike ? "heart.fill" : "heart")
                                .imageScale(.large)
                                .foregroundStyle(didLike ? .red : .white)
                            
                            if post.likes > 0 {
                                Text("\(post.likes)")
                                    .shadow(color: .black, radius: 5, x: 0, y: 5)
                                //.font(.footnote)
                                //.bold()
                            }
                        }
                        
                        Button {
                            showComments.toggle()
                            //print("Album COMMENTS CLICKED")
                        } label: {
                            Image(systemName: "bubble.left")
                                .imageScale(.large)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                            //.foregroundColor(.black)
                            
                            Text("\(post.comments)")
                                .shadow(color: .black, radius: 5, x: 0, y: 5)
                            //.font(.footnote)
                            //.bold()
                        }
                        
                        Button {
                            print("NOTHING - THIS IS JUST A BUTTON FOR VIEWING THE NUMBER OF PHOTOS IN THE ALBUM")
                        } label: {
                            Image(systemName: "photo")
                                .imageScale(.large)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                            //.foregroundColor(.black)
                            Text("\(post.numphotos)")
                                .shadow(color: .black, radius: 5, x: 0, y: 5)
                            //.font(.footnote)
                            //.bold()
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Album BOOKMARKED")
                        } label: {
                            Image(systemName: "bookmark")
                                .imageScale(.large)
                            //.foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .foregroundStyle(.white)
                    
                    
                    //VStack for album title and album description
                    VStack {
                        if let user = post.user {
                            //                        Text(post.albumname)
                            //                            //.font(.footnote)
                            //                            .fontWeight(.bold)
                            //                            .frame(maxWidth: .infinity, alignment: .leading)
                            //                            .padding(.leading, 15)
                            //                            .padding(.bottom, 0.01)
                            
                            Text(post.caption)
                                .font(.footnote)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.trailing, 10)
                                .padding(.vertical, 5)
                                .foregroundStyle(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                            
                            HStack {
                                Text(post.timestamp.timestampString())
                                    .font(.footnote)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 20)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                                
                                Spacer()
                            }
                            
                        }
                        
                    }
                }
                .padding(.bottom, 100)
                
            }

        }
        .background(Color.black)
        .sheet(isPresented: $showComments, content: {
            CommentsView(post: post)
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $showActionSheet) {
            WorldFeedCellBottomSheetView(post: post)
                .presentationDetents([.height(200), .medium])
                .presentationCornerRadius(30)
        }
        
    }
    
    private func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }

    
}








struct WorldFeedCellBottomSheetView: View {
    
    var post: Post
    @State private var isEditAlbumViewPresented = false
    @State private var isUploadToAlbumViewPresented = false
    
    var body: some View {
        NavigationView {
            LazyHStack {
                Button {
                    isEditAlbumViewPresented.toggle()
                } label: {
                    VStack {
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        
                        Text("Save")
                            .font(.subheadline)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Button {
                    isUploadToAlbumViewPresented.toggle()
                } label: {
                    VStack {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)

                        Text("Share")
                            .font(.subheadline)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                
                
                Button {
                    print("QR Code")
                } label: {
                    VStack {
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        Text("QR Code")
                            .font(.subheadline)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
        }
        .padding(.vertical)
        .foregroundStyle(Color(.systemGray))
    }
}







@available(iOS 17.0, *)
struct WorldFeedCell_Previews: PreviewProvider {
    static var previews: some View {
        WorldFeedCell(post: Post.MOCK_POSTS[0])
    }
}
