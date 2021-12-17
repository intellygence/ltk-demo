//
//  LTKDataManager.swift
//  LTK-exercise
//

import Foundation


class LTKDataManager
{
    static func getDetails(index: Int, feed: LTKFeed, completion: @escaping (Details?)-> ())
    {
        var _heroImage = ""
        var _profile = Profile()
        var _products: [Product] = []
        
        let ltk = feed.ltks?[index]
        let profileId = ltk?.profileId
        let profiles = feed.profiles
        let products = feed.products
        
        if let heroImage = ltk?.heroImage
        {
            _heroImage = heroImage
        }
        
        if let profile = profiles?.first(where: {$0.id == profileId})
        {
            _profile = profile
        }
        
        if let ltkId = ltk?.id
        {
            _products = products?.filter { $0.ltkId?.range(of: ltkId, options: .caseInsensitive) != nil } ?? []
        }
        
        completion(Details(heroImage: _heroImage, profile: _profile, products: _products))
    }
}
