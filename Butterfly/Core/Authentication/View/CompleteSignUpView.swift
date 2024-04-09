//
//  CompleteSignUpView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Welcome to Butterfly, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 5)
                .multilineTextAlignment(.center)
            
            Text("Click below to complete registration and begin using Butterfly")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
            
        
            Button {
                Task {try await viewModel.createUser()}
                print("Account created")
            } label: {
                Text("Create Account")
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

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
            .environmentObject(RegistrationViewModel())
    }
}
