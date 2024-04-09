//
//  AlbumPageView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/13/23.
//

import SwiftUI
import Kingfisher

@available(iOS 17.0, *)
struct AlbumPageView: View {
    
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: AlbumPageViewModel
    
    @State private var showComments = false;
    @State private var showActionSheet = false
    @State private var isImageClicked = false
    
    @State private var imageIndex = 0
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private var post: Post {
        return viewModel.post
    }
    
    private var didLike: Bool {
        return post.didLike ?? false
    }
    
    private var isSaved: Bool {
        return post.isSaved ?? false
    }
    
    
    init(post: Post) {
        self.viewModel = AlbumPageViewModel(post: post)
    }
    
    
    var body: some View {
        //need to set background color or something to show that its all ONE post or cell or album
        ZStack {
            ScrollView(showsIndicators: false) {
                ZStack {
//                    Image("towers")
//                        .resizable()
//                        .containerRelativeFrame([.horizontal, .vertical])
//                        .scaledToFill()
//                        .ignoresSafeArea()
//                        .padding(.bottom, 30)

                    
                    //Image or album cover/photo
                    KFImage(URL(string: post.imageUrls[0]))
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame([.horizontal, .vertical])
                        .ignoresSafeArea()
         
                    
                    VStack {
                        HStack {
                            if let user = post.user {
                                CircularProfileImageView(user: user, size: .smallMedium)
                                    .padding(.top, 15)
                                    .padding(.bottom, -10)
                                    .padding(.leading, 10)
                                    .shadow(color: Color.black, radius: 20, x: 0, y: 10)
                        
                                Text(user.username)
                                    .padding(.top, 25)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                            }
                            
                            Spacer()
//                            
//                            Button {
//                                showActionSheet = true
//                            } label: {
//                                Image(systemName: "ellipsis")
//                                    .resizable()
//                                    .frame(width: 30, height: 6)
//                                    .scaledToFit()
//                                    .foregroundStyle(.white)
//                                    .padding(.trailing)
//                                    .padding(.top, 30)
//                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
//                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
//                            }
                            
                        }
                        .padding(.top, 10)
                        .padding(.leading, 10)
                        
                        HStack {
                            if let user = post.user {
                                Text(post.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                            }
                            
                            Spacer()
                            
                            if post.isPrivate {
                                Image(systemName: "lock.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                                    .padding(.trailing, 10)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                            } else {
                                Image(systemName: "lock.open.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    .shadow(color: .black, radius: 2, x: 0, y: 2)
                            }
                            
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                        
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
                                        .foregroundColor(didLike ? .red : .white)
                                    
                                    if post.likes > 0 {
                                        Text("\(post.likes)")
                                            .shadow(color: .black, radius: 5, x: 0, y: 5)
                                            //.shadow(color: .black, radius: 2, x: 0, y: 2)
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
                                        //.shadow(color: .black, radius: 2, x: 0, y: 2)
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
                                        //.shadow(color: .black, radius: 2, x: 0, y: 2)
                                    //.font(.footnote)
                                    //.bold()
                                }
                                
                                Spacer()
                                
                                Button {
                                    handleSaveTapped()
                                    //print("Album BOOKMARKED")
                                } label: {
                                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                        .imageScale(.large)
                                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    //.foregroundColor(.black)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .foregroundColor(.white)
                            
                            
                            //VStack for album title and album description
                            VStack {
                                if let user = post.user {
                                    Text(post.caption)
                                        .font(.footnote)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 20)
                                        .padding(.trailing, 10)
                                        .padding(.vertical, 5)
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                                        .shadow(color: .black, radius: 2, x: 0, y: 2)
                                    
                                    HStack {
                                        Text(post.timestamp.timestampString())
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .padding(.leading, 20)
                                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                                        
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                        }
                        .padding(.bottom, 20)
                        
                    }

                }
                .background(Color.black)
                //.padding(.top, 30)
                .sheet(isPresented: $showComments, content: {
                    CommentsView(post: post)
                        .presentationDragIndicator(.visible)
                })
                
                //POST GRID ALBUM VIEW OF ALL PHOTOS WITHIN THE ALBUM
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach((0 ..< post.imageUrls.count).reversed(), id: \.self) { index in
                        KFImage(URL(string: post.imageUrls[index]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipped()
                            .onTapGesture {
                                isImageClicked.toggle()
                                imageIndex = index
                            }
                    }
                }
                .sheet(isPresented: $isImageClicked) {
                    ImageClicked(post: post, index: imageIndex)
                        .presentationDragIndicator(.visible)
                }
            }
            
            
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: UploadToAlbumView(post: post)) {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                            .padding(.trailing, 10)
                            .shadow(color: .black, radius: 5, x: 0, y: 5)
                    }
                    .navigationBarBackButtonHidden()
                    
                }
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showActionSheet) {
            BottomSheetView(post: post)
                .presentationDetents([.height(400)])
                .presentationCornerRadius(30)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showActionSheet.toggle()
                    //print("3 line bar")
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        .foregroundStyle(.white)
        .background(Color.black)
        

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
    
    private func handleSaveTapped() {
        Task {
            if isSaved {
                try await viewModel.unsave()
            } else {
                try await viewModel.save()
            }
        }
    }

    
}




struct BottomSheetView: View {
    
    var post: Post
    @State private var isEditAlbumViewPresented = false
    @State private var isUploadToAlbumViewPresented = false
    @State private var isSaved = false; //need to set value based on post.isSavedByUser
    
    private var bookmarkIcon: String {
        return isSaved ? "bookmark.fill" : "bookmark"
    }
    
    var body: some View {
        NavigationView {
            LazyHStack {
                Button {
                    isEditAlbumViewPresented.toggle()
                } label: {
                    VStack {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text("Edit")
                            .font(.subheadline)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .fullScreenCover(isPresented: $isEditAlbumViewPresented) {
                    EditAlbumView(title: post.title, caption: post.caption, isPrivate: post.isPrivate, post: post)
                }
                    
                    
                
                    
                Button {
                    isUploadToAlbumViewPresented.toggle()
                } label: {
                    VStack {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 50, height: 50)

                        Text("Add Photos")
                            .font(.subheadline)
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }.fullScreenCover(isPresented: $isUploadToAlbumViewPresented) {
                    UploadToAlbumView(post: post)
                }
                    
                    
                    
                Button {
                    print("QR Code")
                } label: {
                    VStack {
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .frame(width: 50, height: 50)
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


struct ImageClicked: View {
    var post: Post
    var index: Int
    
    var body: some View {
        ZStack {
            KFImage(URL(string: post.imageUrls[index]))
                .resizable()
                .scaledToFit()
        }
    }
}



@available(iOS 17.0, *)
#Preview {
    AlbumPageView(post: Post.MOCK_POSTS[1])
}
