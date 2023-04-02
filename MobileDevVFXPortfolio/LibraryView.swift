//
//  LibraryView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 29/03/2023.
//

import SwiftUI

struct LibraryView: View {
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.black)
    
    // Title typing animation
    @State private var titleWriting = false
    @State private var titleMovingCursor = false
    @State private var titleBlinkingCursor = false
    
    // Body animation
    @State private var readyRenderBody = false
    @State private var firstDisplay = true
    @State private var displayDetailedScreen = false
    
    // Contents options
    @State private var chosenId = 1
    
    // Controller
    @StateObject private var vfxViewController = VFXViewController()
    
    var body: some View {
        VStack {
            Text("Projects Collection")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Text("This page contains the collection of VFX projects in this portfolio. Each of the project will lead to a screen which will show more in-depth information about the project.")
                .padding(.top, nil)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            ZStack {
                HStack {
                    VStack {
                        Divider()
                            .frame(height: 2)
                            .overlay(Color("almost_grey"))
                        
                        Text("\n")
                    }
                }
                HStack {
                    ForEach(vfxViewController.projects) { project in
                        VStack {
                            Divider()
                                .frame(height: 2)
                                .overlay(chosenId == project.id ? .black : Color("almost_grey"))
                            
                            Button(action: {
                                chosenId = project.id
                            }) {
                                Text(project.title)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(chosenId == project.id ? .black : .gray)
                                    .bold()
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, nil)
            
            Spacer()
        
            VStack {
                Text(vfxViewController.projects[chosenId - 1].title)
                    .bold()
                    .font(.title3)
                    .padding(.top, nil)
                    .padding(.leading, nil)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack {
                    Button(action: {
                        displayDetailedScreen = true
                    }) {
                        Image(vfxViewController.projects[chosenId - 1].imageName)
                            .resizable()
                            .frame(height: 210)
                    }
                    .fullScreenCover(isPresented: $displayDetailedScreen) {
                        DetailedProjectView(displayDetailedScreen: $displayDetailedScreen, project: vfxViewController.projects[chosenId - 1])
                    }
                    
                    Button(action: {
                        displayDetailedScreen = true
                    }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .foregroundColor(Color("almost_grey"))
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("theme_color_1_1"), Color("theme_color_1_2"), Color("theme_color_1_3"), Color("theme_color_1_4")]),
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
                                )
                            )
                            .cornerRadius(20)
                            .frame(width: 40, height: 40)
                    }
                }
                HStack {
                    Text(vfxViewController.projects[chosenId - 1].descriptionHeading)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Button(action: {
                        vfxViewController.toggleLike(id: chosenId)
                    }) {
                        Image(systemName: vfxViewController.projects[chosenId - 1].liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .foregroundColor(.black)
                    }
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("theme_color_1_2"),Color("theme_color_1_3"), Color("theme_color_1_4"), Color("theme_color_1_6"), .white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("almost_grey"), lineWidth: 2)
            )
            
            Spacer()
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("theme_color_1_3"), .white, .white, .white, .white, .white]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
        )
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
