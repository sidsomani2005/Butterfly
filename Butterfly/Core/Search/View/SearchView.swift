//
//  SearchView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//
//
//import SwiftUI
//
//@available(iOS 17.0, *)
//struct SearchView: View {
//    
//    @State private var searchText = ""
//    @StateObject var viewModel = SearchViewModel()
//    
//    
//    var body: some View {
//        
//        NavigationStack {
//            UserListView(config: .explore)
//                .navigationDestination(for: User.self, destination: { user in
//                    ProfileView(user: user)
//                })
//                .navigationTitle("Discover")
//                .navigationBarTitleDisplayMode(.inline)
//                .background(Color.black)
//                .foregroundColor(.white)
//        }
//        
//    }
//}
//
//@available(iOS 17.0, *)
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
//

import SwiftUI

@available(iOS 17.0, *)
struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    
    var body: some View {
        NavigationStack {
            UserListView(config: .search)
                .navigationDestination(for: User.self, destination: { user in
                    ProfileView(user: user)
                })
                .navigationTitle("Discover")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.black)
                .foregroundColor(.white)
        }

    }
}

@available(iOS 17.0, *)
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
