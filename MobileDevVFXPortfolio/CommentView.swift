//
//  CommentView.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 25/05/2023.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    var body: some View {
        VStack(alignment: .leading) {
            Text(comment.text).font(.body)
        }
        .padding()
        .foregroundColor(.white)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var comment = Comment.comments[0]
    static var previews: some View {
        CommentView(comment: comment)
    }
}
