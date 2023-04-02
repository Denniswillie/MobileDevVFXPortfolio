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
    
    @State private var brightnessLevel = 0.0
    
    @Binding public var displayDetailedScreen: Bool
    public var project: VFXProject
    @StateObject public var vfxViewController: VFXViewController
    
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.white)
    
    let textColor = Color(.gray)
//    @State var player = AVPlayer(url: URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny")!)
        
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "video1", withExtension: "mp4")!)
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
//                .aspectRatio(400 / 300, contentMode: .fit)
                .frame(height: 250,
                       alignment: .center)
                .brightness(brightnessLevel)
                .onAppear{
                    let item = AVPlayerItem(url: project.videoUrl)
                    player.replaceCurrentItem(with: item)
                    player.play()
//                  if player.currentItem == nil {
//                        let item = AVPlayerItem(url: )
//                        player.replaceCurrentItem(with: item)
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//                        player.play()
//                    })
                }
            
            HStack {
                Text(project.title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button(action: {
                    vfxViewController.toggleLike(id: project.id)
                }) {
                    Image(systemName: vfxViewController.projects[project.id - 1].liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(.white)
                        .padding(.trailing, nil)
                }
            }
            .padding()
            
            Text(project.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, nil)
                .padding(.trailing, nil)
                .foregroundColor(.white)
            
            Text("Adjust Brightness")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, nil)
                .padding(.top, nil)
            
            Slider(value: $brightnessLevel, in: 0...1)
                .padding(.leading, nil)
                .padding(.trailing, nil)
                .tint(.green)
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

struct DetailedProjectView_Previews: PreviewProvider {
    @State static var displayDetailedScreen = true
    static var vfxViewController = VFXViewController()
    static var previews: some View {
        DetailedProjectView(displayDetailedScreen: $displayDetailedScreen, project: vfxViewController.projects[0], vfxViewController: vfxViewController)
    }
}
