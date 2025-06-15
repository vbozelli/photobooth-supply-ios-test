//
//  VideoFrameViewModel.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation
import UIKit

class VideoFrameViewModel: CaptureViewModel {
    
    //MARK: Constants
    private let videoCaptureQueue = DispatchQueue.init(label: "VideoCaptureQueue", qos: .userInteractive)
    
    //MARK: Constructor
    init() {
        let videoDataOutput = AVCaptureVideoDataOutput()
        super.init(captureOutput: videoDataOutput)
    }
    
    override init(captureOutput: AVCaptureOutput!) {
        let videoDataOutput = AVCaptureVideoDataOutput()
        super.init(captureOutput: videoDataOutput)
    }
    
    //MARK: Variables
    private var currentPixelBuffer: CVImageBuffer?
    
    //MARK: Methods
    override func captureImage() {
        guard let buffer = currentPixelBuffer else {
            capturedImage = nil
            return
        }

        let context = CIContext()
        let ciImage = CIImage(cvPixelBuffer: buffer)

        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            capturedImage = nil
            return
        }

        capturedImage = UIImage(cgImage: cgImage)
    }
    
    override func initializeSession(_ cameraManager: CameraManager) {
        let videoDataOutput = captureOutput as? AVCaptureVideoDataOutput
        videoDataOutput?.setSampleBufferDelegate(self, queue: videoCaptureQueue)

        super.initializeSession(cameraManager)
    }
}

//MARK: AVCapturePhotoCaptureDelegate
extension VideoFrameViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        currentPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    }
}
