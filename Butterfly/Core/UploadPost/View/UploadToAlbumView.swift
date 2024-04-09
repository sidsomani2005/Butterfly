////
////  UploadToAlbum.swift
////  Butterfly
////
////  Created by Sid Somani on 12/22/23.
////
//
//
//import SwiftUI
//import PhotosUI
//
//struct UploadToAlbumView: View {
//    @State private var title = ""
//    @State private var caption = ""
//    @State private var imagePickerPresented = false
//    @StateObject var viewModel = UploadPostViewModel()
//    //@Binding var tabIndex: Int
//
//    var body: some View {
//        VStack {
//            // Action toolbar
//            HStack {
//                //cancel btn
//                Button {
//                    clearPostDataAndReturnToFeed()
//                } label: {
//                    Text("Cancel")
//                }
//                Spacer()
//    
//                Text("Upload New Post")
//                    .fontWeight(.semibold)
//
//                Spacer()
//    
//                //upload btn
//                Button {
//                    Task {
//                        try await viewModel.uploadPost(title: title, caption: caption)
//                        clearPostDataAndReturnToFeed()
//                    }
//                    //print("Upload")
//                } label: {
//                    Text("Upload")
//                        .fontWeight(.semibold)
//                }
//            }
//            .padding(.horizontal)
//
//            // Display selected images and caption
//            VStack {
//                if !viewModel.postImages.isEmpty {
//                    TextField("Add title", text: $title)
//                        .font(.title)
//                        .padding()
//                    
//                    TabView {
//                        ForEach(viewModel.postImages.indices, id: \.self) { index in
//                            viewModel.postImages[index]
//                                .resizable()
//                                .scaledToFill()
//                                .tag(index)
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle())
//                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
//                    .frame(height: 300) // Adjust the frame height as needed
//                    
//                    TextField("Enter your caption", text: $caption)
//                        .padding()
//                    
//                    Toggle("Private", isOn: $viewModel.isPrivate)
//                        .padding()
//                } else {
//                    Text("No images selected")
//                        .foregroundColor(.white)
//                        .padding(.top, 100)
//                    
//                    Button {
//                        imagePickerPresented.toggle()
//                    } label: {
//                        Text("Choose image")
//                            .fontWeight(.semibold)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 20)
//                    }
//                    .foregroundColor(.white)
//                    .background(Color.black.opacity(0.9))
//                    .clipShape(.rect(cornerRadius: 15))
//                    .padding(.top, 10)
//                    .padding(.bottom, 40)
//                    .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImages)
//                
//                }
//            }
//
//            
//
//            
//            Spacer()
//            
//            
//                
//        }
//        .onAppear {
//            imagePickerPresented.toggle()
//        }
//        .foregroundColor(.white)
//        .background(Color.black.opacity(0.9))
//        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImages)
//    }
//
//    func clearPostDataAndReturnToFeed() {
//        title = ""
//        caption = ""
//        viewModel.selectedImages = []
//        viewModel.postImages = []
//    }
//    
//    
//}
//
//struct UploadToAlbumView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadToAlbumView()
//    }
//}



import SwiftUI
import PhotosUI

struct UploadToAlbumView: View {
    
    var post: Post
    @StateObject var viewModel = UploadPostViewModel()
    @State private var imagePickerPresented = false
    
    @Environment(\.dismiss) var dismiss

    //@Binding var tabIndex: Int

    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        VStack {
            // Action toolbar
            HStack {
                //cancel btn
                Button {
                    clearPostDataAndReturnToFeed()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                }
                Spacer()
    
                Text("Upload New Post")
                    .fontWeight(.semibold)

                Spacer()
    
                //upload btn
                Button {
                    Task {
                        try await viewModel.addPhotosToAlbum(post: post)
                        clearPostDataAndReturnToFeed()
                    }
                    //print("Upload")
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                }
            }
            .padding(.horizontal)

            // Display selected images and caption
            VStack {
                if !viewModel.postImages.isEmpty {
                    Text(post.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .padding(.top)
                    
                    TabView {
                        ForEach(viewModel.postImages.indices, id: \.self) { index in
                            viewModel.postImages[index]
                                .resizable()
                                .scaledToFill()
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .frame(height: 300) // Adjust the frame height as needed
                    
                } else {
                    Text("No images selected")
                        .foregroundColor(.white)
                        .padding(.top, 100)
                    
                    Button {
                        imagePickerPresented.toggle()
                    } label: {
                        Text("Choose image")
                            .fontWeight(.semibold)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                    }
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.9))
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImages)
                
                }
            }

            Spacer()
                
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            imagePickerPresented.toggle()
        }
        .foregroundColor(.white)
        .background(Color.black.opacity(0.9))
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImages)
    }

    func clearPostDataAndReturnToFeed() {
        viewModel.selectedImages = []
        viewModel.postImages = []
        dismiss()
    }
    
    
}

struct UploadToAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        UploadToAlbumView(post: Post.MOCK_POSTS[0])
    }
}
