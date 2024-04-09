//
//  PostService.swift
//  Butterfly
//
//  Created by Sid Somani on 12/3/23.
//

import Foundation
import Firebase


struct PostService {
    
    private static let postsCollection = FirebaseConstants.PostsCollection

    static func fetchFeedPosts() async throws -> [Post] {
        do {
            let snapshot = try await postsCollection.getDocuments()
            var posts = try snapshot.documents.compactMap({ document in
                let post = try document.data(as: Post.self)
                return post
            })

            for i in 0..<posts.count {
                let post = posts[i]
                let ownerUid = post.ownerUid
                let postUser = try await UserService.fetchUser(withUid: ownerUid)
                posts[i].user = postUser
            }
            
            return posts
            
        } catch {
            print("Error fetching feed posts: \(error)")
            print("Localized Description: \(error.localizedDescription)")
            throw error
        }
    }

    static func fetchUserPosts(uid: String) async throws -> [Post] {
        do {
            let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
            return try snapshot.documents.compactMap({ document in
                let post = try document.data(as: Post.self)
                return post
            })
        } catch {
            print("Error fetching user posts: \(error)")
            print("Localized Description: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    static func fetchPost(_ postId: String) async throws -> Post {
        let snapshot = try await postsCollection.document(postId).getDocument(as: Post.self)
        return snapshot
    }

}





// MARK: ----- LIKES

extension PostService {
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["likes" : post.likes + 1])
        async let _ = FirebaseConstants.UsersCollection.document(uid).collection("user-likes").document(post.id).setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await postsCollection.document(post.id).collection("post-likes").document(uid).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["likes" : post.likes - 1])
        async let _ = FirebaseConstants.UsersCollection.document(uid).collection("user-likes").document(post.id).delete()
        

    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else {return false}
        
        let snapshot = try await FirebaseConstants.UsersCollection.document(uid).collection("user-likes").document(post.id).getDocument()
        
        return snapshot.exists
    }
}







//MARK: ----- Request Access

extension PostService {
    static func unfollowPrivateAlbum(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await postsCollection.document(post.id).collection("post-hasAccess").document(uid).delete()
        async let _ = try await FirebaseConstants.UsersCollection.document(uid).collection("user-hasAccessTo").document(post.id).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["hasAccess" : false])
        
    
    }
    
    static func acceptAccessRequest(uid: String, post: Post) async throws {
        async let _ = try await postsCollection.document(post.id).collection("post-hasAccess").document(uid).setData([:])
        async let _ = FirebaseConstants.UsersCollection.document(uid).collection("user-hasAccessTo").document(post.id).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["hasAccess" : true])
        
    }
    
    //post
    static func checkIfUserHasAccess(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else {return false}

        let snapshot = try await FirebaseConstants.UsersCollection.document(uid).collection("user-hasAccessTo").document(post.id).getDocument()
        
        return snapshot.exists
    }
    
    //uid, post
    static func checkIfUserHasAccessToPost(uid: String, post: Post) async throws -> Bool {
        let snapshot = try await FirebaseConstants.UsersCollection.document(uid).collection("user-hasAccessTo").document(post.id).getDocument()
        
        return snapshot.exists
    }
    
    
    static func fetchUsersThatHaveAccess(post: Post) async throws -> [User] {
        do {
            let postRef = postsCollection.document(post.id)
            let postHasAccessRef = postRef.collection("post-hasAccess")
            let postHasAccessSnapshot = try await postHasAccessRef.getDocuments()
            
            var users = [User]()
            
            if postHasAccessSnapshot.isEmpty {
                return users
            } else {
                for document in postHasAccessSnapshot.documents {
                    if document.data().isEmpty {
                        return []
                    } else {
                        print("Document data: \(document.data())")
                        let user = try document.data(as: User.self)
                        users.append(user)
                    }
                }
                return users
            }
            
        } catch {
            print("Error fetching users that have access: \(error)")
            print("Localized Description: \(error.localizedDescription)")
            print("\n")
            throw error
        }
    }
    
}





//MARK: ----- Save Albums
extension PostService {
    
    static func savePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await postsCollection.document(post.id).collection("post-saved").document(uid).setData([:])
        async let _ = try await postsCollection.document(post.id).updateData(["isSaved" : true])
        async let _ = FirebaseConstants.UsersCollection.document(uid).collection("user-saved").document(post.id).setData([:])
    }
    
    static func unsavePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await postsCollection.document(post.id).collection("post-saved").document(uid).delete()
        async let _ = try await postsCollection.document(post.id).updateData(["isSaved" : false])
        async let _ = FirebaseConstants.UsersCollection.document(uid).collection("user-saved").document(post.id).delete()
    }
    
    
//    static func fetchSavedPosts(uid: String) async throws -> [Post] {
//        do {
//            let snapshot = try await FirebaseConstants.SavedPostsCollection(uid: uid).getDocuments()
//            return try snapshot.documents.compactMap({ document in
//                let post = try document.data(as: Post.self)
//                return post
//            })
//        } catch {
//            print("Error fetching user posts: \(error)")
//            print("Localized Description: \(error.localizedDescription)")
//            throw error
//        }
//    }
    
    static func fetchSavedPosts(uid: String) async throws -> [Post] {
        do {
            // Reference to the "user-saved" subcollection within the "users" collection
            let savedPostsCollection = FirebaseConstants.UsersCollection.document(uid).collection("user-saved")

            // Get documents from the "user-saved" subcollection
            let snapshot = try await savedPostsCollection.getDocuments()

            // Parse the documents and create an array of Post objects
            var savedPosts: [Post] = []

            // Concurrently fetch each saved post using async let
            for document in snapshot.documents {
                async let post = fetchPost(document.documentID)
                savedPosts.append(try await post)
            }

            return savedPosts
            
        } catch {
            print("Error fetching saved posts: \(error)")
            throw error
        }
    }


}


