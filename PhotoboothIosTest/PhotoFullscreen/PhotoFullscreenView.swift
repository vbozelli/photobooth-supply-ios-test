//
//  PhotoFullscreenView.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI

struct PhotoFullscreenView: View {

    //MARK: Variables
    var image: UIImage
    var title: String

    //MARK: View
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .zoomable()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
            //Enable share image
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareImageView(image: image, label: "Photo") {
                        Image(systemName: "square.and.arrow.up.fill")
                    }
                }
            }
    }
}
