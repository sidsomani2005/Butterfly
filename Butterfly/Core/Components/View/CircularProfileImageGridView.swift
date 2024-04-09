//
//  CircularProfileImageGridView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/6/24.
//

import SwiftUI
import Kingfisher

struct CircularProfileImageGridView: View {
    var user: User?
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                //.frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                //.frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

#Preview {
    CircularProfileImageGridView()
}
