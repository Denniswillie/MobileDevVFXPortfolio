//
//  LibraryView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 29/03/2023.
//

import SwiftUI

struct ProjectCardView: View {
    let buttonColor = Color(#colorLiteral(red: 0.4431372549, green: 0.25098039215, blue: 0.78823529411, alpha: 1))
    let cursorColor = Color(.white)
    let items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("space")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Projects")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                    ScrollView {
                        VStack {
                            
                        }
                    }
                }
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
