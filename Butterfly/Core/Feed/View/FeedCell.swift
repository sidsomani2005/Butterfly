//////
//////  FeedCell.swift
//////  Butterfly
//////
//////  Created by Sid Somani on 11/23/23.
//////



import SwiftUI
import Kingfisher

@available(iOS 17.0, *)
struct FeedCell: View {
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    private var update: Update {
        return viewModel.update
    }
    

    init(update: Update) {
        self.viewModel = FeedCellViewModel(update: update)
    }
    
    @State private var currentIndex: Int = 0
    @State private var shareSheet = false
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        //need to set background color or something to show that its all ONE post or cell or album
        
        VStack {
            
            //pfp of poster or photo sharer
            HStack {
                if let user = update.user {
                    NavigationLink (destination: ProfileView(user: user)) {
                        CircularProfileImageView(user: user, size: .small)
                            .padding(.top, 15)
                            .padding(.bottom, -10)
                        //.padding(.leading, 30)
                        
                        Text(user.username)
                            .padding(.top, 30)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                
                HStack {
                    Text("shared to")
                        .font(.subheadline)
                        .padding(.top, 30)

                    
                    if let post = update.post {
                        NavigationLink (destination: AlbumPageView(post: post)) {
                            Text(post.title)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.top, 30)
                        }
                    }
                }

                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 10)
            
            
            
            ZStack {
                ForEach(0 ..< update.uploadedUrls.count, id: \.self) { index in
                    KFImage(URL(string: update.uploadedUrls[index]))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 360, height: 400)
                        .cornerRadius(10)//.cornerRadius(25)
                        .opacity(currentIndex == index ? 1.0 : 0.7)
                        .scaleEffect(currentIndex == index ? 1.0 : 0.65)
                        .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                    
                }
            }
            .gesture(DragGesture()
                .onEnded({ value in
                    let threshold: CGFloat = 50
                    if value.translation.width > threshold {
                        withAnimation {
                            currentIndex = max(0, currentIndex - 1)
                        }
                    } else if value.translation.width < -threshold {
                        withAnimation {
                            currentIndex = min(update.uploadedUrls.count - 1, currentIndex + 1)
                        }
                    }
                })
            )
            
            HStack {
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(.leading, 20)

                
                Spacer()
                
                Text(update.timestamp.timestampString())
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .padding(.top, 15)
                
                Spacer()
                
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                    .onTapGesture {
                        shareSheet.toggle()
                    }
            }
            .padding(.top, 5)
            .padding(.bottom)
            //.padding(.vertical)
            .sheet(isPresented: $shareSheet) {
                if let post = update.post {
                    ShareView(post: post)
                        .presentationDetents([.height(600)])
                        .presentationCornerRadius(30)
                }
            }
            
        }
        .background(Color.black)
        .padding(.horizontal, -1)
        .padding(.bottom, 10)
        .foregroundStyle(.white)

        
    }
    

    
}

@available(iOS 17.0, *)
struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(update: Update.MOCK_UPDATES[0])
    }
}
