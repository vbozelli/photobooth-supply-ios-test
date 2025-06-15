//
//  CameraOrientationHandler.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import AVFoundation
import UIKit

func getCorrectCameraOrientation() -> AVCaptureVideoOrientation {
    
    var orientation: UIInterfaceOrientation?

    //Find the foreground window scene to get the current interface orientation

    let connectedScenes = UIApplication.shared.connectedScenes

    for connectedScene in connectedScenes {

        let activationState = connectedScene.activationState

        if let windowScene = connectedScene as? UIWindowScene,
           activationState == .foregroundActive || activationState == .foregroundInactive {
            orientation = windowScene.interfaceOrientation
        }
    }
    
    if orientation == .landscapeLeft {
        return .landscapeLeft
    }
    
    if orientation == .landscapeRight {
        return .landscapeRight
    }
    
    if orientation == .portraitUpsideDown {
        return .portraitUpsideDown
    }
    
    return .portrait
}
