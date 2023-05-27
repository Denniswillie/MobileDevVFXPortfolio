//
//  VFXProject.swift
//  MobileDevVFXPortfolio
//

import Foundation

struct VFXProject: Identifiable {
    let id: Int
    var title: String
    var descriptionHeading: String
    var description: String
    var videoUrl: URL
    var imageName: String
    var liked: Bool
    var locked: Bool
    
    init(id: Int, title: String, descriptionHeading: String, description: String, videoUrl: URL, imageName: String, liked: Bool, locked: Bool) {
        self.id = id
        self.title = title
        self.descriptionHeading = descriptionHeading
        self.description = description
        self.videoUrl = videoUrl
        self.imageName = imageName
        self.liked = liked
        self.locked = locked
    }
}

extension VFXProject {
    static let projects: [VFXProject] = [
        VFXProject(id: 1, title: "Project Power", descriptionHeading: "VFX Breakdown by Framestore", description: "A VFX breakdown is essentially a task list for visual effects artists or anyone else involved in the creation of visual effects sequences (CGI, compositing, etc). In its most basic form it breaks down a sequence into individual component tasks and provides either estimated times or duration and page references for each task.", videoUrl: Bundle.main.url(forResource: "video1", withExtension: "mp4")!, imageName: "thumbnail_1", liked: false, locked: true),
        VFXProject(id: 2, title: "Personal List", descriptionHeading: "A Collection of Personal Projects.", description: "To all visual elements I've used techniques such as compositing, keying, rotoscoping, camera projection, 3D camera tracking, camera stabilization, matte painting, 3D modelling, lightning, texturing, animation, color correction, etc.", videoUrl: Bundle.main.url(forResource: "video2", withExtension: "mp4")!, imageName: "thumbnail_2", liked: false, locked: true),
        VFXProject(id: 3, title: "Doctor Strange", descriptionHeading: "Fan-made version.", description: "Experience the magic of fan-made cinema with this breathtaking short film, crafted by a talented creative arts student using state-of-the-art VFX technology. From stunning visual effects to immersive sound design, every aspect of this film has been carefully crafted to transport you to a world beyond your imagination.", videoUrl: Bundle.main.url(forResource: "video3", withExtension: "mp4")!, imageName: "thumbnail_3", liked: false, locked: true),
        VFXProject(id: 4, title: "Shang Chi", descriptionHeading: "VFX work documentary.", description: "Discover the behind-the-scenes magic of the critically acclaimed movie 'Shang-Chi' with this captivating documentary. Follow the journey of a skilled VFX artist as they create their own homage to the film, pushing the boundaries of technology and artistic expression to bring their vision to life", videoUrl: Bundle.main.url(forResource: "video4", withExtension: "mp4")!, imageName: "thumbnail_4", liked: false, locked: true)
    ]
}
