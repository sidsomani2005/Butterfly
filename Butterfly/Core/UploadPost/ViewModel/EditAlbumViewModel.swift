//
//  EditAlbumViewModel.swift
//  Butterfly
//
//  Created by Sid Somani on 12/23/23.
//

import Foundation

import Firebase
import SwiftUI

@MainActor
class EditAlbumViewModel: ObservableObject {
    @Published var post: Post
    
    @Published var title = ""
    @Published var caption = ""
    @Published var isPrivate = false
    
    private var uiImage: UIImage?
    
    init(post: Post) {
        self.post = post
        self.title = post.title
        self.caption = post.caption
        self.isPrivate = post.isPrivate
    }

    

    
    func updateAlbumData() async throws {
        //update pfp if changed
        
        var data = [String: Any]()
        
        //update name if changed
        if !title.isEmpty && post.title != title {
            //print("Update title \(title)")
            data["title"] = title
        }
        
        //update bio if changed
        if !caption.isEmpty && post.caption != caption {
            //print("Update bio \(bio)")
            data["caption"] = caption
        }
        
        if post.isPrivate != isPrivate {
            data["isPrivate"] = isPrivate
        }
        
        if !data.isEmpty {
            try await FirebaseConstants.PostsCollection.document(post.id).updateData(data)
        }
        
    }
}
