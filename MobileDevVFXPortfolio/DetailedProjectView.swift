//
//  DetailedProjectView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 29/03/2023.
//

import SwiftUI
import AVKit

struct DetailedProjectView: View {
    // Title typing animation
    @State private var titleWriting = false
    @State private var titleMovingCursor = false
    @State private var titleBlinkingCursor = false
    
    // Description typing animation
    @State private var readyWriteDescription = false
    @State private var descriptionWriting = false
    
    // Explore button
    @State private var displayExploreButton = false
    
    // First time display
    @State private var firstDisplay = true
    
    @Binding public var displayDetailedScreen: Bool
    
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.white)
    
    let textColor = Color(.gray)
    @State var player = AVPlayer(url: URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny")!) // 1
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .frame(width: 400,
                       height: 300,
                       alignment: .center)
            
            HStack {
                Text("Death star")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Image(systemName: "hand.thumbsup")
                    .foregroundColor(.white)
                    .padding(.trailing, nil)
            }
            .padding()
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, nil)
                .padding(.trailing, nil)
                .foregroundColor(.white)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("theme_color_1_1"), Color("theme_color_1_2"), Color("theme_color_1_3"), Color("theme_color_1_4")]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
        )
        .gesture(
            DragGesture()
                .onChanged { value in
                    // Check if the drag direction is downwards
                    if value.translation.height > 0 {
                        // Dismiss the full screen cover
                        displayDetailedScreen = false
                    }
                }
        )
    }
}

//struct DetailedProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedProjectView()
//    }
//}
