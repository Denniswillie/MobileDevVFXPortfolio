//
//  VFXProject.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 02/04/2023.
//

import Foundation

struct VFXProject {
    let id: Int
    var title: String
    var descriptionHeading: String
    var description: String
    var videoUrl: String
    
    init(id: Int, title: String, descriptionHeading: String, description: String, videoUrl: String) {
        self.id = id
        self.title = title
        self.descriptionHeading = descriptionHeading
        self.description = description
        self.videoUrl = videoUrl
    }
}

extension VFXProject {
    static let projects: [VFXProject] = [
        VFXProject(id: 1, title: "Framestore\nBreakdown", descriptionHeading: "", description: "", videoUrl: ""),
        VFXProject(id: 2, title: "Personal\nCompilation", descriptionHeading: "", description: "", videoUrl: ""),
        VFXProject(id: 3, title: "Doctor\nStrange", descriptionHeading: "", description: "", videoUrl: ""),
        VFXProject(id: 4, title: "Shang\nChi", descriptionHeading: "", description: "", videoUrl: "")
    ]
}
