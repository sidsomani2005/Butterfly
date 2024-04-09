//
//  UploadPostViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//


import Foundation
import PhotosUI
import SwiftUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImages: [PhotosPickerItem] = [] {
        didSet {
            if selectedImages.count > 10 {
                // Limit the selected images to 10
                selectedImages = Array(selectedImages.prefix(10))
            }
            loadImages(fromItems: selectedImages)
        }
    }

    @Published var postImages: [Image] = []
    private var uiImages: [UIImage] = []
    
    @Published var isPrivate: Bool = false

    func loadImages(fromItems items: [PhotosPickerItem]) {
        Task {
            var loadedImages: [Image] = []
            var loadedUIImages: [UIImage] = []

            for item in items {
                guard let data = try? await item.loadTransferable(type: Data.self) else { continue }
                if let uiImage = UIImage(data: data) {
                    loadedUIImages.append(uiImage)
                    loadedImages.append(Image(uiImage: uiImage))
                }
            }

            self.uiImages = loadedUIImages
            self.postImages = loadedImages
        }
    }

    func uploadPost(title: String, caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        var uploadedImageUrls: [String] = []

        // Loop through each image to upload
        for uiImage in uiImages {
            guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { continue }
            uploadedImageUrls.append(imageUrl)
        }

        let postRef = FirebaseConstants.PostsCollection.document()

        let post = Post(
            id: postRef.documentID,
            ownerUid: uid,
            title: title,
            caption: caption,
            likes: 0,
            comments: 0,
            numphotos: selectedImages.count,
            imageUrls: uploadedImageUrls, // Assign all uploaded image URLs
            isPrivate: isPrivate,
            timestamp: Timestamp()
        )
        //print("isPrivate: \(self.isPrivate)")

        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }

        try await postRef.setData(encodedPost)
    }
    
    
    
    // UploadPostViewModel.swift

    func addPhotosToAlbum(post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        var updatedImageUrls = post.imageUrls // Make a mutable copy of imageUrls
        
        Task {
            do {
                try await uploadUpdate(post: post, currentUid: uid)
            } catch {
                print("Error during uploadUpdate: \(error.localizedDescription)")
                print("Full message: \(error)")
            }
        }
        
        // Append selected image URLs to the post's imageUrls
        for image in selectedImages {
            guard let data = try? await image.loadTransferable(type: Data.self) else { continue }
            if let uiImage = UIImage(data: data) {
                guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { continue }
                updatedImageUrls.append(imageUrl)
            }
        }
        
        // Update the post's imageUrls with the appended URLs
        let updatedPost = Post(
            id: post.id,
            ownerUid: post.ownerUid,
            title: post.title,
            caption: post.caption,
            likes: post.likes,
            comments: post.comments,
            numphotos: post.numphotos + selectedImages.count, // Update the photo count
            imageUrls: updatedImageUrls,
            isPrivate: post.isPrivate,
            timestamp: Timestamp()
        )

        // Update Firestore with the updated post data
        guard let encodedPost = try? Firestore.Encoder().encode(updatedPost) else { return }
        try await FirebaseConstants.PostsCollection.document(post.id).setData(encodedPost)
        
    }
    
    
    func uploadUpdate(post: Post, currentUid: String) async throws {
        var updateUrls: [String] = []
        let user = try await UserService.fetchUser(withUid: currentUid)
        
        // Loop through each image to upload
        for uiImage in uiImages {
            guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { continue }
            updateUrls.append(imageUrl)
        }
        
        let updateRef = FirebaseConstants.UpdatesCollection.document()
        
        let update = Update(
            id: updateRef.documentID,
            timestamp: Timestamp(),
            uploadedUrls: updateUrls,
            userId: currentUid,
            postId: post.id,
            post: post,
            user: user
        )
        
        //Add update to updates collection
        guard let encodedUpdate = try? Firestore.Encoder().encode(update) else { return }
        try await updateRef.setData(encodedUpdate)
    }

}





