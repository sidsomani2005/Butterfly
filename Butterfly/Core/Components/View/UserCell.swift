//
//  UserCell.swift
//  Butterfly
//
//  Created by Sid Somani on 12/30/23.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .medium)
        
            VStack(alignment: .leading) { // THIS VSTACK IS ONLY FOR ACCOUNTS - MUST MAKE A DIFFERENT ONE TO DISPLAY ALBUMS SINCE ALBUMS DONT HAVE AN ALBUM ID OR USERNAME
                Text(user.username)
                    .fontWeight(.semibold)
        
                if let fullname = user.fullname {
                    Text(user.fullname ?? "")
                        .font(.footnote)
                }
            }
            .foregroundStyle(.white)
        
            Spacer()
        }
        .foregroundColor(.black)
        .padding(.horizontal)
    }
}


#Preview {
    UserCell(user: User.MOCK_USERS[0])
}
