//
//  CaptureViewModel.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation
import UIKit

class CaptureViewModel: NSObject, ObservableObject {
    
    //MARK: Published Variables
    @Published var capturedImage: UIImage?
    
    //MARK: Variables
    private var isObservingOrientationChanges = false
    private(set) var cameraManager: CameraManager!
    private(set) var captureOutput: AVCaptureOutput!
    
    //MARK: Constructor
    init(captureOutput: AVCaptureOutput!) {
        self.captureOutput = captureOutput
    }
    
    //MARK: Destructor
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Methods
    func captureImage() {
    }

    func initializeSession(_ cameraManager: CameraManager) {
        self.cameraManager = cameraManager

        cameraManager.addOutput(output: captureOutput)
        
        //Start capture session configuration transaction
        let captureSession = cameraManager.captureSession
        
        captureSession.beginConfiguration()
        
        //Initialize correct orientation
        configureConnectionOrientation(transaction: false)
        
        //Fix photo mirrored when captured from front camera
        configureIsVideoMirrored()
        
        //Commit capture session configuration transaction
        captureSession.commitConfiguration()

        //React to device orientation change so that we can configure the correct orientation of the capture output
        if !isObservingOrientationChanges {
            isObservingOrientationChanges = true
            NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        }
    }
    
    private func configureConnectionOrientation(transaction: Bool) {
        
        guard let connection = captureOutput.connection(with: .video),
              connection.isVideoOrientationSupported
        else {
            return
        }

        let captureSession = cameraManager.captureSession

        if transaction {
            captureSession.beginConfiguration()
        }
        
        let orientation = getCorrectCameraOrientation()
        connection.videoOrientation = orientation
        
        if transaction {
            captureSession.commitConfiguration()
        }
    }
    
    private func configureIsVideoMirrored() {
        guard let connection = captureOutput.connection(with: .video),
              connection.isVideoMirroringSupported
        else {
            return
        }
        
        connection.automaticallyAdjustsVideoMirroring = false
        connection.isVideoMirrored = true
    }
    
    @objc private func deviceOrientationChanged() {
        configureConnectionOrientation(transaction: true)
    }
}
