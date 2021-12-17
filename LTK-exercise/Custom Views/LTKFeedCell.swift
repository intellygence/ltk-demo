//
//  LTKFeedCell.swift
//  LTK-exercise
//

import UIKit
import Alamofire

class LTKFeedCell: UITableViewCell
{
    @IBOutlet weak var heroImageView: AdjustableHeightImageView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    var request: Request?
    var ltk: LTK!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configure(with ltk: LTK)
    {
        self.ltk = ltk
        reset()
        loadImage()
    }
    
    func reset()
    {
        heroImageView.image = nil
        request?.cancel()
    }
    
    func loadImage()
    {
        loadingIndicator.isHidden = true
        if  let imageUrl = ltk.heroImage,
            let image = LTKImageManager.shared.cachedImage(for: imageUrl) {
            populate(with: image)
            return
        }
        downloadImage()
    }
    
    
    func downloadImage()
    {
        guard let imageUrl = ltk.heroImage
        else
        {
            return
        }
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        request = LTKImageManager.shared.retrieveImage(for: imageUrl) { image in
            self.populate(with: image)
        }
    }
    
    func populate(with image: UIImage)
    {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
        heroImageView.image = image
    }
}



