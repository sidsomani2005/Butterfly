//
//  UploadPostView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//



import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var title = ""
    @State private var caption = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int

    var body: some View {
        VStack {
            // Action toolbar
            HStack {
                //cancel btn
                Button {
                    clearPostDataAndReturnToFeed()
                } label: {
                    Text("Cancel")
                }
                Spacer()
    
                Text("Upload New Post")
                    .fontWeight(.semibold)

                Spacer()
    
                //upload btn
                Button {
                    Task {
                        try await viewModel.uploadPost(title: title, caption: caption)
                        clearPostDataAndReturnToFeed()
                    }
                    //print("Upload")
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)

            // Display selected images and caption
            VStack {
                if !viewModel.postImages.isEmpty {
                    TextField("Add title", text: $title)
                        .font(.title)
                        .padding()
                    
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
                    
                    TextField("Enter your caption", text: $caption)
                        .padding()
                    
                    Toggle("Private", isOn: $viewModel.isPrivate)
                        .padding()
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
        .onAppear {
            imagePickerPresented.toggle()
        }
        .foregroundColor(.white)
        .background(Color.black.opacity(0.9))
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImages)
    }

    func clearPostDataAndReturnToFeed() {
        title = ""
        caption = ""
        viewModel.selectedImages = []
        viewModel.postImages = []
        tabIndex = 0
    }
    
    
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView(tabIndex: .constant(0))
    }
}
