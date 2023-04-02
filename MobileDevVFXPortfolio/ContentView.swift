//
//  ContentView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 29/03/2023.
//

import SwiftUI

struct ContentView: View {
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
    
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.white)
    
    let textColor = Color(.gray)
    
    // Controller
    @StateObject private var vfxViewController = VFXViewController()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mobile Development CA 1")
                .font(.title3)
                .foregroundColor(.white)
                .padding()
            
            Spacer().frame(height: 50)
            
            ZStack(alignment: .leading) {
                Text("VFX Portfolio")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .mask(Rectangle().offset(x: titleWriting ? 0 : -250))
                
                Rectangle()
                    .fill(cursorColor)
                    .opacity(titleBlinkingCursor ? 1 : 0)
                    .frame(width: 3, height: 35)
                    .offset(x: titleMovingCursor ? 210 : 0)
            }
            .onAppear {
                if firstDisplay {
                    withAnimation(.easeOut(duration: 2).delay(1)) {
                        titleWriting = true
                        titleMovingCursor = true
                    }
                    
                    withAnimation(.easeInOut(duration: 0.6)
                        .repeatForever()
                    ) {
                        titleBlinkingCursor.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                        titleBlinkingCursor = false
                        readyWriteDescription = true
                    }
                }
            }
            .padding(.leading, nil)
            
            if readyWriteDescription {
                Text("This portfolio contains VFX projects which includes demo videos and VFX breakdowns.")
                    .font(.body)
                    .foregroundColor(.white)
                    .opacity(descriptionWriting ? 1 : 0)
                .onAppear {
                    if firstDisplay {
                        withAnimation(.easeOut(duration: 2)) {
                            descriptionWriting = true
                            displayExploreButton = true
                            firstDisplay = false
                        }
                    }
                }
                .padding(.leading, nil)
            }
            
            Spacer().frame(height: 50)
            
            if displayExploreButton {
                ProgressView(value: 4, total: 16)
                    .padding(.leading, nil)
                    .padding(.trailing, nil)
                    .tint(.white)
                Spacer().frame(height: 20)
                NavigationLink(destination: LibraryView(vfxViewController: vfxViewController)) {
                    HStack {
                        Text("EXPLORE")
                            .fontWeight(.bold)
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white)
                    }
                    .padding(.leading, nil)
                    .padding(.trailing, nil)
                }
                Spacer().frame(height: 20)
                Divider()
                    .frame(height: 3)
                    .overlay(Color("almost_grey"))
                    .padding(.leading, nil)
                    .padding(.trailing, nil)
                    .cornerRadius(3)
                
                Spacer()
                
                Text("Disclaimer")
                    .padding(.leading, nil)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("The VFX projects examples in this portfolio are entirely outsourced. The contents of the portfolio are not the primary goal of the CA, it's the UI that counts intead.")
                    .padding(.leading, nil)
                    .padding(.trailing, nil)
                    .font(.body)
                
                Spacer()
                
                Text("By Dennis Willie - D00225835")
                    .padding(.leading, nil)
                    .font(.caption)
            }
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
                gradient: Gradient(colors: [Color("theme_color_1_1"), Color("theme_color_1_2"), Color("theme_color_1_3"), Color("theme_color_1_4"), Color("theme_color_1_5"), .white]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }.accentColor(.black)
    }
}
