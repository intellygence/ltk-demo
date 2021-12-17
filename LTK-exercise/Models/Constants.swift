//
//  Constants.swift
//  LTK-exercise
//

import Foundation

struct CellIdentifers
{
    static let feedCell = "LTKFeedCell"
    static let productCollectionViewCell = "LTKProductCollectionViewCell"
    static let collectionHeaderView = "LTKCollectionHeaderView"
    static let productHeaderView = "LTKProductHeaderView"
}

struct API
{
    static let feedUrl = "https://api-gateway.rewardstyle.com/api/ltk/v2/ltks/?featured=true&limit=25"
}

struct Segues
{
    static let detailSegue = "DetailViewControllerSegue"
}

struct Titles
{
    static let ltk = "LTK"
}

struct Keys
{
    static let hideShadow = "hidesShadow"
}
