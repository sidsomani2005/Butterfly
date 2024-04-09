//
//  SplashScreenView.swift
//  Butterfly
//
//  Created by Sid Somani on 12/30/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var opacity = 0.5
    
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Butterfly")
                    .font(.system(size: 45))
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 0.922, green: 0.988, blue: 0.659))
                
                Image("butterfly_icon_cropped")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.0)) {
                    self.opacity = 1.0
                }
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
        
        
    }
}

@available(iOS 17.0, *)
#Preview {
    SplashScreenView()
}
