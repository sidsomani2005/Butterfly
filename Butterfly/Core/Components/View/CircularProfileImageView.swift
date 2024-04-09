//
//  CircularProfileImageView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/2/23.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case xsmall
    case smallMedium
    case small
    case medium
    case large
    case xlarge
    var dimension: CGFloat {
        switch self {
        case .xsmall:
            return 25
        case .smallMedium:
            return 30
        case .small:
            return 40
        case .medium:
            return 60
        case .large:
            return 80
        case .xlarge:
            return 100
        }
    }
}


struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .foregroundColor(Color(.systemGray4))
        }
    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
    }
}
