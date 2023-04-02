//
//  SliderView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 01/04/2023.
//

import SwiftUI

struct ImageSlider: View {
    
    // 1
    private let images = ["1", "2", "3", "4"]
    
    var body: some View {
        // 2
        TabView {
            ForEach(images, id: \.self) { item in
                 //3
                 Image(item)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ImageSlider_Previews: PreviewProvider {
    static var previews: some View {
        // 4
        ImageSlider()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
