//
//  LTKCollectionHeaderView.swift
//  LTK-exercise
//

import UIKit

protocol LTKCollectionHeaderViewDelegate: AnyObject
{
    func blogAction()
}

class LTKCollectionHeaderView: UICollectionReusableView
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    {
        didSet
        {
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        }
    }
    @IBOutlet weak var blogButton: UIButton!
    {
        didSet
        {
            blogButton.layer.cornerRadius = 4
        }
    }
    
    weak var delegate: LTKCollectionHeaderViewDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
    
    func configureView(profile: Profile)
    {
        let name = profile.fullName
        let imageManager = LTKImageManager.shared
        
        nameLabel.text = name
        
        if  let avatarUrl = profile.avatarUrl
        {
            let avatarImage = imageManager.cachedImage(for: avatarUrl)
            
            if avatarImage != nil {
                profileImageView.image = avatarImage
            }
            else
            {
                _ = imageManager.retrieveImage(for: avatarUrl) { image in
                    self.profileImageView.image = image
                }
            }
        }
    }
    
    @IBAction func blogbuttonTapped()
    {
        delegate?.blogAction()
    }
}
