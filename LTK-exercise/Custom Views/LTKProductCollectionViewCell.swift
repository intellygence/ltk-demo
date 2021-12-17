//
//  LTKProductCollectionViewCell.swift
//  LTK-exercise
//

import UIKit

class LTKProductCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var  imageView: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configureCell(imageUrl: String)
    {
        let imageManager = LTKImageManager.shared
        let image = imageManager.cachedImage(for: imageUrl)
        
        if image != nil
        {
            imageView.image = image
        }
        else
        {
            _ = imageManager.retrieveImage(for: imageUrl) { image in
                self.imageView.image = image
            }
        }
    }
}
