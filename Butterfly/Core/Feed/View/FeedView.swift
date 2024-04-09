//
//  FeedView.swift
//  Butterfly
//
//  Created by Sid Somani on 11/23/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 5) {
                    ForEach((0 ..< viewModel.updates.count).reversed(), id: \.self) { index in
                        FeedCell(update: viewModel.updates[index])
                            .padding(.bottom)
                    }

                }
                .padding(.top, 20)

            }
            .background(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Butterfly")
                        .font(.title)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NotificationsView()) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 30)
                            .padding(.trailing, 10)
                            .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                    }
                    
                }
            }
            .foregroundColor(.white)
            
        }
        
        
        
    }
}

@available(iOS 17.0, *)
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
