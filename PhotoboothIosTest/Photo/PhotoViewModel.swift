//
//  PhotoViewModel.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation
import UIKit

class PhotoViewModel: CaptureViewModel {

    //MARK: Constructors
    init() {
        let photoOutput = AVCapturePhotoOutput()
        super.init(captureOutput: photoOutput)
    }
    
    override init(captureOutput: AVCaptureOutput!) {
        let photoOutput = AVCapturePhotoOutput()
        super.init(captureOutput: photoOutput)
    }
    
    //MARK: Methods
    override func captureImage() {
        let photoOutput = self.captureOutput as? AVCapturePhotoOutput
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
}

//MARK: AVCapturePhotoCaptureDelegate
extension PhotoViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        
        if let error = error {
            //TODO: Handle error
            print("error = \(error.localizedDescription)")
            return;
        }
        
        if let photoData = photo.fileDataRepresentation(),
           let photoImage = UIImage(data: photoData) {
            DispatchQueue.main.async {
                self.capturedImage = photoImage
            }
        }
    }
}
