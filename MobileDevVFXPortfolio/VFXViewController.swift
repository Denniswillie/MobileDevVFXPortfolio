//
//  VFXViewController.swift
//  MobileDevVFXPortfolio
//
//  Created by Dennis Willie on 02/04/2023.
//

import Foundation

class VFXViewController: ObservableObject {
    @Published var projects: [VFXProject] = VFXProject.projects
    
    func toggleLike(id: Int) {
        projects[id - 1].liked = !projects[id - 1].liked
    }
}
