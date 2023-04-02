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
        VStack {
            Text("Death star explosion")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
//            GeometryReader { geo in
                Image("vfx_1")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(14.0)
//            }
            Spacer()
            Text("Project Description")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(10)
    }
}

struct ProjectCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCardView()
    }
}
