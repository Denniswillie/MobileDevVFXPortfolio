//
//  CommentsView.swift
//  MobileDevVFXPortfolio
//

import SwiftUI

struct CommentsView: View {
    @State public var projectId: Int
    @StateObject public var vfxViewController: VFXViewController
    @State private var text: String = "Enter comment"
    @Environment(\.presentationMode) var presentationMode
    @Binding public var fullScreenCoverType: LibraryView.FullScreenCoverType
    
    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .frame(width: 50, height: 3)
                    .cornerRadius(10)
                    .foregroundColor(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
                Text(vfxViewController.projects[projectId - 1].title)
                    .font(.title)
                    .padding()
                    .foregroundColor(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
                    .bold()
                List(vfxViewController.comments.filter { (comment) -> Bool in
                    return comment.vfxProjectId == projectId
                }, id: \.id) { comment in
                    CommentView(comment: comment, vfxViewController: vfxViewController)
                        .listRowBackground(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
                }
                .cornerRadius(0)
                TextField("Enter comment", text: $text)
                    .padding()
                    .onTapGesture {
                        if text == "Enter comment" {
                            text = ""
                        }
                    }
                    .onSubmit {
                        vfxViewController.authenticateWithFaceIDForComment(){success in
                            if success {
                                vfxViewController.addComment(projectId: projectId, text: text)
                                text = "Enter comment"
                            }
                        }
                    }
                    .foregroundColor(.white)
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
        .background(Color(#colorLiteral(red: Float(18) / 255, green: Float(19) / 255, blue: Float(26) / 255, alpha: 1)))
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
