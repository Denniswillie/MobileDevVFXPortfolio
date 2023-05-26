//
//  LibraryView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie and Jeremy Neo
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
    
    public enum FullScreenCoverType {
        case none, detailed, comment
    }
    @State private var fullScreenCoverType: FullScreenCoverType = FullScreenCoverType.none
    
    @StateObject public var vfxViewController: VFXViewController
    
    // Contents options
    @State private var chosenId = 1
    
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
                HStack{
                    Text(vfxViewController.projects[chosenId - 1].title)
                        .bold()
                        .font(.title3)
                        .padding(.top, nil)
                        .padding(.leading, nil)
                        .foregroundColor(.black)
                    Spacer()
                }
                ZStack {
                    Button(action: {
                        if vfxViewController.projects[chosenId - 1].locked {
                            vfxViewController.authenticateWithFaceID(id: chosenId, view: false){success in
                                if success {
                                    fullScreenCoverType = FullScreenCoverType.detailed
                                }
                            }
                        } else {
                            fullScreenCoverType = FullScreenCoverType.detailed
                        }
                    }) {
                        Image(vfxViewController.projects[chosenId - 1].imageName)
                            .resizable()
                            .frame(height: 210)
                    }
                    .fullScreenCover(isPresented: Binding<Bool>(
                        get: { fullScreenCoverType != FullScreenCoverType.none },
                        set: { newValue in
                            // Handle changes to the fullScreenCoverType property if needed
                        }
                    )) {
                        if (fullScreenCoverType == FullScreenCoverType.detailed) {
                            DetailedProjectView(fullScreenCoverType: $fullScreenCoverType, project: vfxViewController.projects[chosenId - 1], vfxViewController: vfxViewController)
                        } else if (fullScreenCoverType == FullScreenCoverType.comment) {
                            CommentsView(projectId: chosenId , vfxViewController: vfxViewController, fullScreenCoverType: $fullScreenCoverType)
                        }
                    }
                    
                    Button(action: {
                        if vfxViewController.projects[chosenId - 1].locked {
                            vfxViewController.authenticateWithFaceID(id: chosenId, view: false){success in
                                if success {
                                    fullScreenCoverType = FullScreenCoverType.detailed
                                }
                            }
                        } else {
                            fullScreenCoverType = FullScreenCoverType.detailed
                        }
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
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                    Button(action: {
                        fullScreenCoverType = FullScreenCoverType.comment
                    }) {
                        Image(systemName: "message")
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        vfxViewController.toggleLike(id: chosenId)
                    }) {
                        Image(systemName: vfxViewController.projects[chosenId - 1].liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .foregroundColor(.black)
                    }
                }
                .padding()
            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
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
    static var vfxViewController = VFXViewController()
    static var previews: some View {
        NavigationView {
            LibraryView(vfxViewController: vfxViewController)
        }
        .accentColor(.black)
    }
}
