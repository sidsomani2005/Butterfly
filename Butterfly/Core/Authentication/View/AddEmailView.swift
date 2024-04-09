//
//  AddEmailView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import SwiftUI

struct AddEmailView: View {
    //@State private var email = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        
        VStack {
            Text("Add Your Email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.bottom, 5)
            
            Text("You will use this email to sign in to your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
            
            TextField("Email", text: $viewModel.email)
                .font(.subheadline)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 25)
                .padding(.vertical)
            
        
            NavigationLink {
                CreateUsernameView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 360, height: 45)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            
            Spacer()
            
        }.toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                    
            }
        }

        
        
    }
}

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
            .environmentObject(RegistrationViewModel())
    }
}
