//
//  LoginView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import SwiftUI

struct LoginView: View {
    
    //@State private var email = ""
    //@State private var password = ""
    //@StateObject var registrationViewModel = RegistrationViewModel()
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                Text("Butterfly")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.922, green: 0.988, blue: 0.659))


                 
                
                //text
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .textInputAutocapitalization(.none)
                        .font(.subheadline)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    SecureField("Password", text: $viewModel.password)
                        .font(.subheadline)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                } //VStack INNER
                .padding(.top, 20)
                
                //forgot pw button
                Button {
                    print("Show forgot password")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                }
                
                
                //login button
                Button {
                    Task {try await viewModel.signIn()}
                    print("Logged In")
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(width: 360, height: 45)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.vertical)
                }
                
                
                
                HStack {
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width / 2 - 40, height: 0.5)
                      
                }
                .foregroundColor(.gray)
                

                
                HStack {
                    Button {
                        print("Logging in through gmail")
                    } label: {
                        HStack(spacing: 3) {
                            Image(systemName: "envelope")
                                .resizable()
                                .frame(width: 20, height: 15)
                                .padding(5)
                                .foregroundColor(.black)
                            
                            Text("Continue with Gmail")
                                .padding(5)
                                .foregroundColor(.black)
                            
                        }
                        .padding(5)
                        .background(Color(red: 0.922, green: 0.988, blue: 0.659))
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    .padding(.vertical, 10)
                }
                
                Spacer()
                
                Divider()

                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 5) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    
                    
                }
                .padding(.vertical, 15) 
               
                
            } //VStack OUTER
            .background(Color.black)
            
        } //NavigationStack
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(RegistrationViewModel())
    }
}
