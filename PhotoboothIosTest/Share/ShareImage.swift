//
//  ShareImage.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI

struct ShareImage<Content: View>: View {
    
    //MARK: Constants
    private let content: () -> Content

    //MARK: Variables
    var image: Image
    var label: String
    
    //MARK: Constructor
    init(image: Image, label: String, @ViewBuilder content: @escaping () -> Content) {
        self.image = image
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
