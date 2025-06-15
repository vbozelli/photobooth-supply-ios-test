//
//  ShareImageView.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI

struct ShareImageView<Content: View>: View {
    
    //MARK: Constants
    private let content: () -> Content
    private let image: ShareableImage

    //MARK: Variables
    var label: String
    
    //MARK: Constructor
    init(image: UIImage, label: String, @ViewBuilder content: @escaping () -> Content) {
        self.image = ShareableImage(image: image, fileName: label)
        self.label = label
        self.content = content
    }
    
    //MARK: View
    var body: some View {
        ShareLink(item: image, preview: SharePreview(label, image: image)) {
            content()
        }
    }
}
