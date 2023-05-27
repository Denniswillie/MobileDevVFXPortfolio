//
//  LibraryView.swift
//  MobileDevVFXPortfolio
//

import SwiftUI

struct LibraryView: View {
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.black)
    let navButtonColor = Color(#colorLiteral(red: Float(34) / 255, green: Float(38) / 255, blue: Float(55) / 255, alpha: 1))
    let navButtonForegroundColor = Color(#colorLiteral(red: Float(132) / 255, green: Float(150) / 255, blue: Float(167) / 255, alpha: 1))
    let color = Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1))
    let dark = Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1))
    
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
        VStack(alignment: .leading) {
            Text("Projects Collection")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.bottom, 2)
            
            Text("This page contains the collection of VFX projects in this portfolio. Each of the project will lead to a screen which will show more in-depth information about the project.")
                .padding(.top, 1)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            
            Spacer().frame(height: 30)
        
            VStack {
                ZStack(alignment: .bottomTrailing) {
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
                        VStack {
                            Text(vfxViewController.projects[chosenId - 1].title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
                                .cornerRadius(20)
                            Image(vfxViewController.projects[chosenId - 1].imageName)
                                .resizable()
                                .frame(height: 390)
                                .cornerRadius(20)
                        }
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
                    
//                    Button(action: {
//                        if vfxViewController.projects[chosenId - 1].locked {
//                            vfxViewController.authenticateWithFaceID(id: chosenId, view: false){success in
//                                if success {
//                                    fullScreenCoverType = FullScreenCoverType.detailed
//                                }
//                            }
//                        } else {
//                            fullScreenCoverType = FullScreenCoverType.detailed
//                        }
//                    }) {
//                        Image(systemName: "play.circle.fill")
//                            .resizable()
//                            .foregroundColor(Color("almost_grey"))
//                            .background(
//                                LinearGradient(
//                                    gradient: Gradient(colors: [Color("theme_color_1_1"), Color("theme_color_1_2"), Color("theme_color_1_3"), Color("theme_color_1_4")]),
//                                    startPoint: .bottomLeading,
//                                    endPoint: .topTrailing
//                                )
//                            )
//                            .cornerRadius(20)
//                            .frame(width: 40, height: 40)
//                    }
                    
                    HStack {
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
                            Text("Show Details")
                                .font(.body)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                                .fontWeight(.bold)
                                .foregroundColor(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
                        }
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(20)
                            .offset(x: -10, y: -10)
                            .padding(.leading)
                        
                        Button(action: {
                            fullScreenCoverType = FullScreenCoverType.comment
                        }) {
                            Image(systemName: "message.fill")
                                .resizable()
                                .foregroundColor(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .background(.white)
                        .cornerRadius(25)
                        .offset(x: -10, y: -10)
                        
                        Button(action: {
                            vfxViewController.toggleLike(id: chosenId)
                        }) {
                            Image(systemName: vfxViewController.projects[chosenId - 1].liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .resizable()
                                .foregroundColor(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .background(.white)
                        .cornerRadius(25)
                        .offset(x: -10, y: -10)
                    }
                }
                
//                HStack {
//                    Text(vfxViewController.projects[chosenId - 1].descriptionHeading)
//                        .foregroundColor(.black)
//                        .bold()
//                }
//                .padding()
            }
            
            Spacer()
            
            ZStack {
                Divider()
                    .frame(height: 8)
                    .overlay(.black)
                
                HStack {
                    ZStack(alignment: .leading) {
                        if chosenId == 1 {
                            Button(action: {
//                                                        if vfxViewController.projects[chosenId - 1].locked {
//                                                            vfxViewController.authenticateWithFaceID(id: chosenId, view: false){success in
//                                                                if success {
//                                                                    fullScreenCoverType = FullScreenCoverType.detailed
//                                                                }
//                                                            }
//                                                        } else {
//                                                            fullScreenCoverType = FullScreenCoverType.detailed
//                                                        }
                                fullScreenCoverType = FullScreenCoverType.detailed
                                                    }) {
                                Text(vfxViewController.projects[chosenId - 1].title)
                                    .font(.body)
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                                .frame(minWidth: 45, maxWidth: .infinity)
                                .background(dark)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.2)) {
                                chosenId = 1
                            }
                        }) {
                            Image(systemName: "power.circle.fill")
                                .resizable()
                                .foregroundColor(chosenId == 1 ? .white : navButtonForegroundColor)
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .background(chosenId == 1 ? color : navButtonColor)
                        .cornerRadius(25)
                        .offset(x: chosenId == 1 ? 4 : 0)
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        if chosenId == 2 {
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
                                Text(vfxViewController.projects[chosenId - 1].title)
                                    .font(.body)
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                                .frame(minWidth: 45, maxWidth: .infinity)
                                .background(dark)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.2)) {
                                chosenId = 2
                            }
                        }) {
                            Image(systemName: "list.bullet.circle.fill")
                                .resizable()
                                .foregroundColor(chosenId == 2 ? .white : navButtonForegroundColor)
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .background(chosenId == 2 ? color : navButtonColor)
                        .cornerRadius(25)
                        .offset(x: 4)
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        if chosenId == 3 {
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
                                Text(vfxViewController.projects[chosenId - 1].title)
                                    .font(.body)
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                                .frame(minWidth: 45, maxWidth: .infinity)
                                .background(dark)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.2)) {
                                chosenId = 3
                            }
                        }) {
                            Image(systemName: "globe.asia.australia.fill")
                                .resizable()
                                .foregroundColor(chosenId == 3 ? .white : navButtonForegroundColor)
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .background(chosenId == 3 ? color : navButtonColor)
                        .cornerRadius(25)
                        .offset(x: 4)
                    }
                    
                    Spacer()
                    ZStack(alignment: .leading) {
                        if chosenId == 4 {
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
                                Text(vfxViewController.projects[chosenId - 1].title)
                                    .font(.body)
                                    .padding(.top, 15)
                                    .padding(.bottom, 15)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                                .frame(minWidth: 45, maxWidth: .infinity)
                                .background(dark)
                                .cornerRadius(20)
                        }
                        
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.2)) {
                                chosenId = 4
                            }
                        }) {
                            Image(systemName: "film.circle")
                                .resizable()
                                .foregroundColor(chosenId == 4 ? .white : navButtonForegroundColor)
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        .background(chosenId == 4 ? color : navButtonColor)
                        .cornerRadius(25)
                        .offset(x: 4)
                    }
                }
            }
            
            Spacer()
            
//            ZStack {
//                HStack {
//                    VStack {
//                        Divider()
//                            .frame(height: 2)
//                            .overlay(Color("almost_grey"))
//
//                        Text("\n")
//                    }
//                }
//                HStack {
//                    ForEach(vfxViewController.projects) { project in
//                        VStack {
//                            Divider()
//                                .frame(height: 2)
//                                .overlay(chosenId == project.id ? .black : Color("almost_grey"))
//
//                            Button(action: {
//                                chosenId = project.id
//                            }) {
//                                Text(project.title)
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(chosenId == project.id ? .black : .gray)
//                                    .bold()
//                            }
//                        }
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.top, nil)
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
                        gradient: Gradient(colors: [Color("almost_grey"), .white]),
                        startPoint: .bottom,
                        endPoint: .top
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
