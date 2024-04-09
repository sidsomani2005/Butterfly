//
//  EditProfileView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/28/23.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    //@State private var selectedImage: PhotosPickerItem?
    //@State private var fullname = ""
    //@State private var bio = ""
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            //toolbar on top
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0.922, green: 0.988, blue: 0.659))
                            
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.trailing, 10)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        Task {try await viewModel.updateUserData()}
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                    }
                     
                    
                }
                
                .padding(.horizontal)
                
                Divider()
            }
            
            //edit pfp
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                    } else {
                        CircularProfileImageView(user: viewModel.user, size: .large)
                    }

                    
                    Text("Edit Profile Picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical, 5)
                        .padding(.bottom, 15)
                        .foregroundColor(Color(.systemBlue))
                    
                    
                    Divider()
                        .background(Color(.systemGray))
                }
            }
            .padding(.vertical, 10)
            
            //edit profile info
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.fullname)
                Divider()
                EditProfileRowView(title: "Bio", placeholder: "Enter bio", text: $viewModel.bio)
            }
            .padding(.vertical, 10)
            .foregroundColor(.white)
            
            Spacer()
        }
        .background(Color.black)
    }
}


struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        
        HStack {
            Text(title)
                .padding(.leading, 10)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                Divider()
                    .background(Color.gray)
            }
        }
        .font(.subheadline)
        .frame(height: 35)
        
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User.MOCK_USERS[0])
    }
}
