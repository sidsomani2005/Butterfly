//
//  CurrentUserProfileView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/24/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct CurrentUserProfileView: View {
    
    let user: User
    
    @State private var showScreen = false

    var body: some View {
        NavigationStack {
            ScrollView {
                //header
                ProfileHeaderView(user: user)
                
                //album grid view
                PostGridView(user: user)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showScreen.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showScreen) {
                SelectionScreen(user: user)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(20)
                    .background(Color.black)
            }
            .background(Color.black)
            .foregroundColor(.white)
        }
    }
}




@available(iOS 17.0, *)
struct SelectionScreen: View {
    
    @State private var isSavedAlbumsPresented = false
    let user: User
    
    var body: some View {
        NavigationView {
            LazyHStack {
                Button {
                    isSavedAlbumsPresented.toggle()
                } label: {
                    VStack {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: 60, height: 80)
                        
                        Text("Saved Albums")
                            .font(.subheadline)
                    }
                    .padding()
                    .background(Color(red: 0.25, green: 0.25, blue: 0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .sheet(isPresented: $isSavedAlbumsPresented) {
                    //SavedAlbumsView(user: user)
                    SavedAlbumsDecisionView(user: user)
                        .presentationDragIndicator(.visible)
                }
                
//                .fullScreenCover(isPresented: $isSavedAlbumsPresented) {
//                    //SavedAlbumsView(user: user)
//                    SavedAlbumsDecisionView(user: user)
//                }
//                
                
                
                
                Button {
                    AuthService.shared.signout()
                } label: {
                    VStack {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding(.leading, 30)
                        
                        Text("Logout")
                            .font(.subheadline)
                    }
                    .padding()
                    .padding(.top, 5)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
            }
                
        }
        .padding(.vertical)
        .foregroundStyle(.white)
        .background(Color.black)
    }
        
}


@available(iOS 17.0, *)
struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: User.MOCK_USERS[0])
    }
}
