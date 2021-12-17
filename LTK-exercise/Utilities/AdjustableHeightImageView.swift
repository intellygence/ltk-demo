//
//  AdjustableHeightImageView.swift
//  LTK-exercise
//

import Foundation
import UIKit

class AdjustableHeightImageView: UIImageView
{
    override var intrinsicContentSize: CGSize
    {
        if let image = self.image
        {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            let viewWidth = self.frame.size.width
 
            let ratio = viewWidth/imageWidth
            let scaledHeight = imageHeight * ratio

            return CGSize(width: viewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }
}
