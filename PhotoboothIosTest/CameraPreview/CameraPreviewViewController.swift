//
//  CameraPreviewViewController.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation
import UIKit

class CameraPreviewViewController: UIViewController {
    
    //MARK: Constants
    private let previewLayer = AVCaptureVideoPreviewLayer()
    
    //MARK: Variable
    private var captureSession: AVCaptureSession!
    
    //MARK: UIViewController
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        //Resize camera preview layer when the screen resizes
        //Like when  the orientation of the device changes
        previewLayer.frame = CGRect(origin: .zero, size: size)

        //Change the orientation of the connection to match with the device orientation
        configureOrientation()
    }
    
    //MARK: Methods
    func configurePreview(_ captureSession: AVCaptureSession) {
        self.captureSession = captureSession

        previewLayer.session = captureSession
        
        let bounds = view.bounds
        previewLayer.frame = bounds
        
        previewLayer.videoGravity = .resizeAspectFill
        
        //Initialize correct orientation
        configureOrientation()
        
        view.layer.addSublayer(previewLayer)
    }
    
    private func configureOrientation() {
        captureSession.beginConfiguration()

        guard let connection = previewLayer.connection,
              connection.isVideoOrientationSupported
        else {
            return
        }
        
        let cameraOrientation = getCorrectCameraOrientation()
        connection.videoOrientation = cameraOrientation
        
        captureSession.commitConfiguration()
    }
}
