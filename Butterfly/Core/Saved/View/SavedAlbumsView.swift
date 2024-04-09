//
//  SavedAlbumsView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/12/24.
//

import SwiftUI
import Kingfisher

@available(iOS 17.0, *)
struct SavedAlbumsView: View {
    @StateObject var viewModel: SavedAlbumsViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: SavedAlbumsViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 5),
        .init(.flexible(), spacing: 5),
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 2) - 25
    
    private var user: User {
        return viewModel.user
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
//            VStack {
//                HStack {
//                    Image(systemName: "chevron.down.circle.fill")
//                        .imageScale(.large)
//                        .foregroundStyle(Color.white)
//                        .onTapGesture {
//                            dismiss()
//                        }
//                        .padding(.vertical, 30)
//                        .padding(.horizontal, 20)
//                    
//                    Spacer()
//                }
                
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.savedPosts) { post in
                        NavigationLink(destination: AlbumPageView(post: post)) {
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
                            .padding(.bottom, 5)
                            
                        }
                    }
                }
//            }
           
        }
        .ignoresSafeArea()
        //.background(Color.black)
        .foregroundStyle(.white)
        
    }
    

}

@available(iOS 17.0, *)

#Preview {
    SavedAlbumsView(user: User.MOCK_USERS[0])
}
