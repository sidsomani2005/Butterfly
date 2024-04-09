//
//  ProfileView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/23/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct ProfileView: View {
    
    let user: User
    @Environment(\.dismiss) var dismiss
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        
        //NavigationStack {
            
            ScrollView {
                //header
                ProfileHeaderView(user: user)
                
                //album grid view
                PostGridView(user: user)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image(systemName: "line.3.horizontal")
//                        .foregroundStyle(.white)
//
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Image(systemName: "chevron.left")
//                        .imageScale(.large)
//                        .onTapGesture {
//                            dismiss()
//                        }
//                }
//            }
            .background(Color.black)
            .foregroundStyle(.white)
//            
            
        //}
    }
}

@available(iOS 17.0, *)
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User.MOCK_USERS[0])
    }
}
