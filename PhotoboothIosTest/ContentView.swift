//
//  ContentView.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: State Variables
    @State private var capturedPhoto = false
    @State private var capturedVideoFrame = false
    @State private var showPictures = false
    @StateObject private var cameraManager = CameraManager()
    
    //MARK: View
    var body: some View {

        NavigationStack {

            VStack {

                if cameraManager.permissionGranted {
                    
                    GeometryReader { geometry in
                        
                        let isPortrait = geometry.size.height > geometry.size.width
                        
                        let container = isPortrait ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
                        
                        if cameraManager.isCaptureReady {
                            
                            container {
                                CameraPreviewView()
                                
                                VStack {

                                    Text(!capturedPhoto ? "Photo" : "Video Frame")
                                        .background(.white)
                                        .foregroundStyle(.black)

                                    Button(action: captureImage) {
                                        Image(systemName: "camera")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 30))
                                            .frame(width: 60, height: 60)
                                            .background(Circle().fill(.white))
                                    }
                                }
                                .frame(maxWidth: isPortrait ? .infinity : 100, maxHeight: isPortrait ? 100 : .infinity)
                                .background(.black.opacity(0.5))
                            }
                        }
                        
                        container {
                            
                            //Photo
                            CaptureView(didCaptureImage: $capturedPhoto, isCaptureReady: $cameraManager.isCaptureReady, showImage: $showPictures, captureViewModel: PhotoViewModel(), title: "Photo")
                            
                            //Video Frame
                            CaptureView(didCaptureImage: $capturedVideoFrame, isCaptureReady: $cameraManager.isCaptureReady, showImage: $showPictures, captureViewModel: VideoFrameViewModel(), title: "Video Frame")
                        }
                        .opacity(showPictures ? 1 : .zero)
                    }
                }
                else {
                    Text("Tap the button below to be redirected to the app settings and enable the Camera permission")
                        .padding()
                    
                    Button("Go to App Settings", action: goToAppSettings)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .foregroundStyle(.black)
                        .padding(.top, 8)
                        
                }
            }
            .environmentObject(cameraManager)
            .navigationBarHidden(!showPictures)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Photos")
            .toolbar {
                if showPictures {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: resetScreen) {
                            Text("Reset")
                        }
                    }
                }
            }
        }
        .tint(.white)
        .task {
            await cameraManager.startSession()
        }
    }
    
    //MARK: Methods
    private func captureImage() {
        if !capturedPhoto {
            capturedPhoto = true
        }
        else {
            capturedVideoFrame = true
            showPictures = true
            cameraManager.stopSession()
        }
    }
    
    private func goToAppSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    private func resetScreen() {
        capturedPhoto = false
        capturedVideoFrame = false
        showPictures = false
        Task {
            await cameraManager.startSession()
        }
    }
}
