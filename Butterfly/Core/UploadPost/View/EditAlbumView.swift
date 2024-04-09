//
//  EditAlbumView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/23/23.
//

import SwiftUI
import Kingfisher

struct EditAlbumView: View {
    
    @State private var title = ""
    @State private var caption = ""
    @State private var isPrivate = false
    @StateObject var viewModel = UploadPostViewModel()
    @StateObject var editViewModel: EditAlbumViewModel
    
    @Environment(\.dismiss) var dismiss
    
    init(title: String, caption: String, isPrivate: Bool, post: Post) {
        _title = State(initialValue: title)
        _caption = State(initialValue: caption)
        _isPrivate = State(initialValue: isPrivate)
        
        self._editViewModel = StateObject(wrappedValue: EditAlbumViewModel(post: post))
    }
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    
    
    var body: some View {
        VStack {
            // Action toolbar
            HStack {
                //cancel btn
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0.922, green: 0.988, blue: 0.659))
                }
                
                Spacer()
    
                Text("Edit Album")
                    .font(.headline)
                    .fontWeight(.bold)

                Spacer()
    
                //upload btn
                Button {
                    Task {
                        try await editViewModel.updateAlbumData()
                    }
                    dismiss()
                    print("Edits saved")
                } label: {
                    Text("Save")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 0.922, green: 0.988, blue: 0.659))
                }
            }
            .padding(.horizontal)

            // Display selected images and caption
            VStack {
                TextField("Add title", text: $editViewModel.title)
                    .font(.title)
                    .padding()
                    .background(Color.black)
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.horizontal, 5)
                    
                    
                TextField("Enter your caption", text: $editViewModel.caption)
                    .padding()
                    .padding(.horizontal, 5)
                    
                Toggle("Private", isOn: $editViewModel.isPrivate)
                    .padding()
                    .padding(.horizontal, 5)
                    .padding(.top)
            }
            .padding(.top)

            //Spacer()
            Divider()
                .foregroundColor(.white)
                .padding(.vertical)
            
            //POST GRID ALBUM VIEW OF ALL PHOTOS WITHIN THE ALBUM
            ScrollView (showsIndicators: false) {
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach(0 ..< editViewModel.post.imageUrls.count, id: \.self) { index in
                        KFImage(URL(string: editViewModel.post.imageUrls[index]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipped()
                    }
                }
            }
                        
                
        }
        .foregroundColor(.white)
        .background(Color.black.opacity(0.9))
        .navigationBarBackButtonHidden()
    }

}

#Preview {
    EditAlbumView(title: "title", caption: "caption", isPrivate: true, post: Post.MOCK_POSTS[0])
}
