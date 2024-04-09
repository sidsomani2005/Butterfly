//
//  WorldFeedView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/11/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct WorldFeedView: View {
    @StateObject var viewModel = WorldFeedViewModel()
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 0) {
                    ForEach(viewModel.posts) { post in
                        WorldFeedCell(post: post)
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .ignoresSafeArea()
            
        }
        
        
        
    }
}


@available(iOS 17.0, *)
#Preview {
    WorldFeedView()
}

