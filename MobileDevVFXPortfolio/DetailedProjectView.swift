//
//  DetailedProjectView.swift
//  MobileDevVFXPortfolio
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
    
    @Binding public var fullScreenCoverType: LibraryView.FullScreenCoverType
    public var project: VFXProject
    @StateObject public var vfxViewController: VFXViewController
    
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.white)
    
    let textColor = Color(.gray)
    let slightGray = Color(#colorLiteral(red: Float(226) / 255, green: Float(232) / 255, blue: Float(236) / 255, alpha: 1))
//    @State var player = AVPlayer(url: URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny")!)
        
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "video1", withExtension: "mp4")!)
    let playerViewController = AVPlayerViewController()
    
    var body: some View {
        VStack (alignment: .leading) {
            Button(action: {
                fullScreenCoverType = LibraryView.FullScreenCoverType.none
            }) {
                Image(systemName: "chevron.backward.circle.fill")
                    .resizable()
                    .foregroundColor(slightGray)
                    .frame(width: 40, height: 40)
            }
            .background(.black)
            .cornerRadius(25)
            .padding(.leading, 20)
            
            Text(project.title)
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.top, 10)
                .padding(.leading, 20)
                .padding(.bottom, 1)
            
            Text(project.descriptionHeading)
                .font(.body)
                .foregroundColor(.black)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.leading, 20)
            
            VideoPlayer(player: player)
                .frame(height: 250,
                       alignment: .center)
                .brightness(brightnessLevel)
                .onAppear{
                    let item = AVPlayerItem(url: project.videoUrl)
                    player.replaceCurrentItem(with: item)
                    player.play()
                }
                .cornerRadius(30)
                .padding(20)
            
            VStack {
                HStack {
                    Text("Description")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        fullScreenCoverType = LibraryView.FullScreenCoverType.comment
                    }) {
                        Image(systemName: "message.fill")
                            .resizable()
                            .foregroundColor(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
                            .frame(width: 20, height: 20)
                            .padding(10)
                    }
                    .background(.white)
                    .cornerRadius(25)
                    Button(action: {
                        vfxViewController.toggleLike(id: project.id)
                    }) {
                        Image(systemName: vfxViewController.projects[project.id - 1].liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .resizable()
                            .foregroundColor(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
                            .frame(width: 20, height: 20)
                            .padding(10)
                    }
                    .background(.white)
                    .cornerRadius(25)
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 20)
                
                Text(project.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
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
                    .tint(Color(#colorLiteral(red: Float(34) / 255, green: Float(38) / 255, blue: Float(55) / 255, alpha: 1)))
                    .padding(.bottom, 20)
            }
            .background(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
            .cornerRadius(20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .gesture(
            DragGesture()
                .onChanged { value in
                    // Check if the drag direction is downwards
                    if value.translation.height > 0 {
                        // Dismiss the full screen cover
                        fullScreenCoverType = LibraryView.FullScreenCoverType.none
                    }
                }
        )
        .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.gray, slightGray, slightGray, slightGray, slightGray, slightGray, slightGray, slightGray,  .white]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    )
                )
    }
}

struct DetailedProjectView_Previews: PreviewProvider {
    @State static var fullScreenCoverType = LibraryView.FullScreenCoverType.detailed
    static var vfxViewController = VFXViewController()
    static var previews: some View {
        DetailedProjectView(fullScreenCoverType: $fullScreenCoverType, project: vfxViewController.projects[0], vfxViewController: vfxViewController)
    }
}
