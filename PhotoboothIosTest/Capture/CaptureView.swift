//
//  CaptureView.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI

struct CaptureView: View {
    
    //MARK: Bindings
    @Binding var didCaptureImage: Bool
    @Binding var isCaptureReady: Bool
    @Binding var showImage: Bool
    
    //MARK: Environment Objects
    @EnvironmentObject private var cameraManager: CameraManager
    
    //MARK: State Variables
    @StateObject var captureViewModel: CaptureViewModel
    
    //MARK: Variables
    var title: String

    //MARK: View
    var body: some View {
        VStack {
            if showImage, let capturedImage = captureViewModel.capturedImage {
                
                let image = Image(uiImage: capturedImage)

                NavigationLink {
                    PhotoFullscreen(image: capturedImage, title: title)
                } label: {
                    image
                        .resizable()
                        .scaledToFit()
                }
                
                ShareImage(image: image, label: title) {
                    Label("Share \(title)", systemImage: "square.and.arrow.up.fill")
                        .foregroundStyle(.black)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //Configure photo output just after the capture session is configured and starts
        .onChange(of: isCaptureReady) { newIsCaptureReady in
            if newIsCaptureReady {
                captureViewModel.initializeSession(cameraManager)
            }
        }
        .onChange(of: didCaptureImage) { newDidCaptureImage in
            if newDidCaptureImage {
                captureViewModel.captureImage()
            }
            else {
                captureViewModel.capturedImage = nil
            }
        }
    }
}
