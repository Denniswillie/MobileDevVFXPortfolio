//
//  VFXViewController.swift
//  MobileDevVFXPortfolio
//

import Foundation
import LocalAuthentication

class VFXViewController: ObservableObject {
    @Published var projects: [VFXProject] = VFXProject.projects
    @Published var comments: [Comment] = Comment.comments
    var toggleDisplayHandler: ((Bool) -> Void)?

    
    func authenticateWithFaceID(id: Int, view: Bool, completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?

        // Check if the device supports biometric authentication (Face ID or Touch ID)
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access the content"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.projects[id - 1].locked.toggle()
                        completion(true)
                    } else {
                        print("failed")
                        completion(false)
                    }
                }
            }
        } else {
            print("Biometric authentication not available or not configured on the device")
            completion(false)
        }
    }

    
    func toggleLike(id: Int) {
        projects[id - 1].liked = !projects[id - 1].liked
    }
    
    func addComment(projectId: Int, text: String) {
        comments.append(Comment(vfxProjectId: projectId, text: text))
    }
    
    func removeComment(id: UUID) {
        let newComments = comments.filter { (comment) -> Bool in
            return comment.id != id
        }
        comments = newComments
    }
}
