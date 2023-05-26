//
//  Comment.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 25/05/2023.
//

import Foundation

struct Comment: Identifiable {
    let id: UUID
    let vfxProjectId: Int
    var text: String
    
    init(id: UUID = UUID(), vfxProjectId: Int, text: String) {
        self.id = id
        self.vfxProjectId = vfxProjectId
        self.text = text
    }
}

extension Comment {
    static let comments: [Comment] = [
        Comment(vfxProjectId: 1, text: "This is so cool!"),
        Comment(vfxProjectId: 1, text: "Definitely West will like this project! Congrats!"),
        Comment(vfxProjectId: 2, text: "I think this is the coolest project compilation I've seen so far!"),
        Comment(vfxProjectId: 2, text: "Nice!"),
        Comment(vfxProjectId: 3, text: "This is so nice, I really like it!"),
        Comment(vfxProjectId: 3, text: "Very cool! Please make a tutorial for this and post it on Youtube :)"),
        Comment(vfxProjectId: 4, text: "I really like this :)"),
        Comment(vfxProjectId: 4, text: "5/5!"),
    ]
}

