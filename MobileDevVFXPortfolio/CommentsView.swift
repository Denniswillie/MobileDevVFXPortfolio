//
//  CommentsView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 25/05/2023.
//

import SwiftUI

struct CommentsView: View {
    @State public var projectId: Int
    @StateObject public var vfxViewController: VFXViewController
    @State private var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding public var fullScreenCoverType: LibraryView.FullScreenCoverType
    
    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .frame(width: 50, height: 3)
                    .cornerRadius(10)
                    .foregroundColor(.gray)
                Text(vfxViewController.projects[projectId - 1].title)
                    .font(.title3)
                    .padding()
                List(vfxViewController.comments.filter { (comment) -> Bool in
                    return comment.vfxProjectId == projectId
                }, id: \.id) { comment in
                    CommentView(comment: comment)
                        .listRowBackground(LinearGradient(
                            gradient: Gradient(colors: [Color("theme_color_1_1"), Color("theme_color_1_2"), Color("theme_color_1_3")]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        ))
                }
                TextField("Enter comment", text: $text)
                    .padding()
                    .onSubmit {
                        vfxViewController.addComment(projectId: projectId, text: text)
                        text = ""
                    }
            }
        }
        .padding(.top, 20) // Add padding to the top
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
//        .gesture(
//                    DragGesture()
//                        .onEnded { value in
//                            if value.translation.height > 100 {
//                                presentationMode.wrappedValue.dismiss()
//                            }
//                        }
//                )
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var projectId = 1
    @State static var fullScreenCoverType = LibraryView.FullScreenCoverType.comment
    static var vfxViewController = VFXViewController()
    static var previews: some View {
        CommentsView(projectId: projectId, vfxViewController: vfxViewController, fullScreenCoverType: $fullScreenCoverType)
    }
}
