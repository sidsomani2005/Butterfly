//
//  CreatePasswordView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import SwiftUI

struct CreatePasswordView: View {
    //@State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        
        VStack {
            Text("Create Password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.bottom, 5)
            
            Text("Your password must be at least 8 characters")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
            
            TextField("Password", text: $viewModel.password)
                .font(.subheadline)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 25)
                .padding(.vertical)
            
        
            NavigationLink {
                CompleteSignUpView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Continue")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(width: 360, height: 45)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.vertical)
            }
            
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

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
            .environmentObject(RegistrationViewModel())
    }
}


