//
//  CommentView.swift
//  MobileDevVFXPortfolio
//

import SwiftUI

//xmark.circle.fill

struct CommentView: View {
    let comment: Comment
    @StateObject public var vfxViewController: VFXViewController
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(comment.text).font(.body)
                Spacer()
                Button(action: {
                    vfxViewController.authenticateWithFaceIDForComment(){success in
                        if success {
                            vfxViewController.removeComment(id: comment.id)
                        }
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                }
                .background(Color(#colorLiteral(red: Float(234) / 255, green: Float(82) / 255, blue: Float(35) / 255, alpha: 1)))
                .cornerRadius(25)
            }
        }
        .padding()
        .foregroundColor(.black)
        .bold()
    }
}

struct CommentView_Previews: PreviewProvider {
    static var comment = Comment.comments[0]
    static var vfxViewController = VFXViewController()
    static var previews: some View {
        CommentView(comment: comment, vfxViewController: vfxViewController)
    }
}
