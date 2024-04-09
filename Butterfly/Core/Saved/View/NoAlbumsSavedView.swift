//
//  NoAlbumsSavedView.swift
//  Butterfly
//
//  Created by Sid Somani on 1/13/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct NoAlbumsSavedView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
//            VStack {
//                HStack {
//                    Image(systemName: "chevron.down.circle.fill")
//                        .imageScale(.large)
//                        .foregroundStyle(Color.white)
//                        .onTapGesture {
//                            dismiss()
//                        }
//                        .padding(.vertical, 30)
//                        .padding(.horizontal, 20)
//                    
//                    Spacer()
//                }
                
                Spacer()

//                VStack {
                    Text("No Albums Saved")
                        .font(.title3)
                    
    //                NavigationLink (destination: WorldFeedView()) {
    //                    VStack {
    //                        Text("Find Albums")
    //                            .font(.subheadline)
    //                            .foregroundStyle(Color.white)
    //                            .padding()
    //                            .padding(.horizontal)
    //                    }
    //                    .background(Color.gray.opacity(0.2))
    //                    .clipShape(.rect(cornerRadius: 15))
    //                }
//                }
                
                Spacer()
//            }
           
        }
//        .toolbar{
//            ToolbarItem(placement: .navigationBarLeading) {
//                Image(systemName: "chevron.left")
//                    .imageScale(.large)
//                    .foregroundStyle(Color.white)
//                    .onTapGesture {
//                        dismiss()
//                    }
//            }
//        }
        .foregroundStyle(.white)
        .edgesIgnoringSafeArea(.all)
    }
}

@available(iOS 17.0, *)
#Preview {
    NoAlbumsSavedView()
}
