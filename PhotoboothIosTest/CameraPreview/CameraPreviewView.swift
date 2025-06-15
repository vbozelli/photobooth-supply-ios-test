//
//  CameraPreviewView.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation
import SwiftUI
import UIKit

struct CameraPreviewView: UIViewControllerRepresentable {
    
    //MARK: Environment Variables
    @EnvironmentObject private var cameraManager: CameraManager
    
    //MARK: UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = CameraPreviewViewController()
        viewController.configurePreview(cameraManager.captureSession)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
