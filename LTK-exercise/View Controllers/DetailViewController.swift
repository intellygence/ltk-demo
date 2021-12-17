//
//  DetailViewController.swift
//  LTK-exercise
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    var details: Details?
    let headerHeight: CGFloat = 70
    let heroCellHeight: CGFloat = 400
    let numberOfCellsInRow = 3
    let numberOfSections = 2
    
    enum sections: Int {
        case hero = 0
        case product
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = details?.profile.displayName
        configureCollectionView()
    }
    
    func configureCollectionView()
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CellIdentifers.productCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifers.productCollectionViewCell)
        
        collectionView.register(UINib(nibName: CellIdentifers.collectionHeaderView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifers.collectionHeaderView)
        
        collectionView.register(UINib(nibName: CellIdentifers.productHeaderView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifers.productHeaderView)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.sectionHeadersPinToVisibleBounds = true
            collectionView.collectionViewLayout = layout
        }
    }
    
    func openUrl(_ urlString: String)
    {
        guard let url = URL(string: urlString)
        else
        {
            return
        }
        
        if #available(iOS 10.0, *)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else
        {
            UIApplication.shared.openURL(url)
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == sections.hero.rawValue
        {
            return 1
        }
        else
        {
            return details?.products.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifers.productCollectionViewCell, for: indexPath) as? LTKProductCollectionViewCell
        {
            if indexPath.section == sections.hero.rawValue
            {
                if let imageUrl = details?.heroImage
                {
                    productCell.configureCell(imageUrl: imageUrl)
                }
            }
            else
            {
                if let imageUrl = details?.products[indexPath.row].imageUrl
                {
                    productCell.configureCell(imageUrl: imageUrl)
                }
            }
            return productCell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if let urlString = details?.products[indexPath.row].hyperlink,
           indexPath.section == sections.product.rawValue
        {
            openUrl(urlString)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            if indexPath.section == sections.hero.rawValue
            {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifers.collectionHeaderView, for: indexPath) as? LTKCollectionHeaderView
                {
                    if let profile = details?.profile
                    {
                        headerView.delegate = self
                        headerView.configureView(profile: profile)
                    }
                    return headerView
                }
                else
                {
                    return UICollectionReusableView()
                }
            }
            else
            {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifers.productHeaderView, for: indexPath) as? LTKProductHeaderView
                {
                    return headerView
                }
                else
                {
                    return UICollectionReusableView()
                }
            }
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: self.collectionView.frame.width, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if indexPath.section == sections.hero.rawValue
        {
            return CGSize(width: collectionView.bounds.size.width, height: heroCellHeight)
        }
        else
        {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
            
            return CGSize(width: size, height: size)
        }
    }
}

extension DetailViewController: LTKCollectionHeaderViewDelegate
{
    func blogAction()
    {
        if let blogUrl = details?.profile.blogUrl
        {
            var formattedUrl = ""
            
            if blogUrl.hasPrefix("https://") || blogUrl.hasPrefix("http://")
            {
                formattedUrl = blogUrl
            }
            else
            {
                formattedUrl = "http://\(blogUrl)"
            }
            
            openUrl(formattedUrl)
        }
    }
}



