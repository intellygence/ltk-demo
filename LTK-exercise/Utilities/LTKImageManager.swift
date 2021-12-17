//
//  LTKImageManager.swift
//  LTK-exercise
//

import UIKit
import Alamofire
import AlamofireImage


class LTKImageManager
{
    static var shared = LTKImageManager()
    
    private init() {}
    
    var imageCache = AutoPurgingImageCache (
        memoryCapacity: 100 * 1024 * 1024,
        preferredMemoryUsageAfterPurge: 60 * 1024 * 1024
    )
    
    //MARK: - Image Downloading
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request
    {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value
            else
            {
                return
            }
            completion(image)
            self.cache(image, for: url)
        }
    }
    
    //MARK: - Image Caching
    
    func cache(_ image: Image, for url: String)
    {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image?
    {
        return imageCache.image(withIdentifier: url)
    }
}
