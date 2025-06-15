//
//  ShareableImage.swift
//  PhotoboothIosTest
//
//  Created by Victor Bozelli Alvarez on 15/06/25.
//

import SwiftUI
import UIKit

struct ShareableImage: Transferable {

    //MARK: Variables
    var image: UIImage!
    var fileName: String

    //MARK: Transfearable
    static var transferRepresentation: some TransferRepresentation {
        let dataRepresentation = DataRepresentation(exportedContentType: .jpeg) { (shareableImage: ShareableImage) in
            shareableImage.image.jpegData(compressionQuality: 1) ?? Data()
        }
        
        if #available(iOS 17.0, *) {
            return dataRepresentation.suggestedFileName { shareableImage in
                shareableImage.fileName + ".jpeg"
            }
        }
        
        return dataRepresentation.suggestedFileName("PhotoboothImage.jpeg")
    }
}
