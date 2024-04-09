//
//  DecisionView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/14/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct SavedAlbumsDecisionView: View {
    
    @StateObject var viewModel: SavedAlbumsViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: SavedAlbumsViewModel(user: user))
    }
    
    private var user: User {
        return viewModel.user
    }
    
    
    var body: some View {
        if viewModel.savedPosts.count > 0 {
            SavedAlbumsView(user: user)
        } else {
            NoAlbumsSavedView()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    SavedAlbumsDecisionView(user: User.MOCK_USERS[0])
}
