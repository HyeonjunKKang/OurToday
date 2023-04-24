//
//  Image+Extension.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/21.
//

import Foundation
import SwiftUI
import UIKit

extension Image{
    init?(data: Data) {
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            return nil
        }
    }
}

extension UIImage{
    func resize(to size: CGSize) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: size)
            let scaledImage = renderer.image { _ in
                self.draw(in: CGRect(origin: .zero, size: size))
            }
            return scaledImage
        }
}
