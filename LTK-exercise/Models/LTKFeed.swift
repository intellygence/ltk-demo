//
//  LTKFeed.swift
//  LTK-exercise
//

import Foundation

struct LTKFeed: Codable
{
    var ltks: [LTK]?
    var profiles: [Profile]?
    var products: [Product]?
}

struct LTK: Codable
{
    var heroImage: String?
    var id: String?
    var profileId: String?
    var profileUserId: String?
    var caption: String?
    var productIds: [String]?
}

struct Profile: Codable
{
    var id: String?
    var avatarUrl: String?
    var displayName: String?
    var fullName: String?
    var blogUrl: String?
}

struct Product: Codable
{
    var id: String?
    var ltkId: String?
    var hyperlink: String?
    var imageUrl: String?
}

struct Details: Codable
{
    var heroImage: String
    var profile: Profile
    var products: [Product]
    
    init(heroImage: String, profile: Profile, products: [Product])
    {
        self.heroImage = heroImage
        self.profile = profile
        self.products = products
    }
}


extension LTKFeed
{
    init(data: Data) throws
    {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self = try decoder.decode(LTKFeed.self, from: data)
    }
}
