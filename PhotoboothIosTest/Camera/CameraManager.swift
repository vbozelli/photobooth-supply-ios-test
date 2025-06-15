//
//  CameraManager.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation

class CameraManager: ObservableObject {

    //MARK: Constants
    private(set) var captureSession = AVCaptureSession()
    
    //MARK: Published Variables
    @Published var isCaptureReady = false
    @Published var permissionGranted = AVCaptureDevice.authorizationStatus(for: .video) == .authorized

    //MARK: Methods
    func addOutput(output: AVCaptureOutput) {
        captureSession.beginConfiguration()

        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }

        captureSession.commitConfiguration()
    }
    
    func startSession() async {
        if !permissionGranted {
            let permissionGranted = await AVCaptureDevice.requestAccess(for: .video)
            
            await MainActor.run {
                self.permissionGranted = permissionGranted
            }
        }

        if !permissionGranted {
            return
        }

        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            //TODO: Handle case that the device does not have a front camera
            return
        }

        do {
            
            if captureSession.inputs.isEmpty  {
                let input = try AVCaptureDeviceInput(device: camera)
                
                guard captureSession.canAddInput(input) else {
                    //TODO: Handle case that the input can't be added to the capture session
                    return
                }
                
                captureSession.beginConfiguration()
                
                captureSession.addInput(input)
                
                captureSession.commitConfiguration()
            }

            self.captureSession.startRunning()

            await MainActor.run {
                self.isCaptureReady = true
            }
        }
        catch let e {
            //TODO: Handle exception
            return
        }
    }
    
    func stopSession() {
        self.isCaptureReady = false
        self.captureSession.stopRunning()
    }
}
