//
//  ContentView.swift
//  MobileDevVFXPortfolio
//

import SwiftUI

struct ContentView: View {
    // Animation states
    @State private var progressValue1: Float = 0
    @State private var progressValue2: Float = 0
    @State private var progressValue3: Float = 0
    @State private var isIncreasing = true
    @State private var currentDisplayedImage = "image1"
    @State private var workItem1: DispatchWorkItem?
    @State private var workItem2: DispatchWorkItem?
    @State private var workItem3: DispatchWorkItem?
    @State private var workItem4: DispatchWorkItem?
        
    // Controller
    @StateObject private var vfxViewController = VFXViewController()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ProgressView(value: progressValue1, total: 10)
                    .padding(.leading, 4)
                    .padding(.trailing, 4)
                    .tint(.white)
                ProgressView(value: progressValue2, total: 10)
                    .padding(.leading, 4)
                    .padding(.trailing, 4)
                    .tint(.white)
                ProgressView(value: progressValue3, total: 10)
                    .padding(.leading, 4)
                    .padding(.trailing, 4)
                    .tint(.white)
            }
            .padding(.leading)
            .padding(.trailing)
            
            Spacer().frame(height: 40)
            
            Text("VFX Portfolio")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding(.leading)
            Spacer().frame(height: 10)
            Text("This portfolio contains VFX projects which includes demo videos and VFX breakdowns.")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.leading)
                .padding(.trailing)
            
            Image(currentDisplayedImage)
                .resizable()
            
            NavigationLink(destination: LibraryView(vfxViewController: vfxViewController)) {
                Text("Explore the Portfolio")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
                    .cornerRadius(24)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            Spacer().frame(height: 30)
            
            Text("by Dennis Willie & Jeremy Neo")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .padding(.leading)
                .padding(.trailing)
        }
        .onAppear {
            animate()
        }
        .onDisappear {
            progressValue1 = 0
            progressValue2 = 0
            progressValue3 = 0
            workItem1?.cancel()
            workItem2?.cancel()
            workItem3?.cancel()
            workItem4?.cancel()
            currentDisplayedImage = "image1"
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(.black)
    }
    
    func animate() {
        workItem1 = DispatchWorkItem {
            withAnimation(Animation.linear(duration: 0)) {
                progressValue1 = 10
                currentDisplayedImage = "image1"
            }
        }
        
        if let workItem1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem1)
        }
        
        workItem2 = DispatchWorkItem {
            withAnimation(Animation.linear(duration: 1)) {
                progressValue2 = 10
                currentDisplayedImage = "image2"
            }
        }
        if let workItem2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: workItem2)
        }
        
        workItem3 = DispatchWorkItem {
            withAnimation(Animation.linear(duration: 1)) {
                progressValue3 = 10
                currentDisplayedImage = "image3"
            }
        }
        
        if let workItem3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: workItem3)
        }
        
        workItem4 = DispatchWorkItem {
            progressValue1 = 0
            progressValue2 = 0
            progressValue3 = 0
            
            withAnimation(Animation.linear(duration: 1)) {
                currentDisplayedImage = "image1"
            }
            
            animate()
        }
        if let workItem4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: workItem4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }.accentColor(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
    }
}
