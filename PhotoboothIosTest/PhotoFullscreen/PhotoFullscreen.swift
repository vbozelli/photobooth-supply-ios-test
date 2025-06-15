//
//  PhotoFullscreen.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI

struct PhotoFullscreen: View {

    //MARK: Variables
    var image: UIImage
    var title: String

    //MARK: View
    var body: some View {
        
        let image = Image(uiImage: image)

        image
            .resizable()
            .scaledToFit()
            .zoomable()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            //Enable share image
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareImage(image: image, label: "Photo") {
                        Image(systemName: "square.and.arrow.up.fill")
                    }
                }
            }
    }
}
