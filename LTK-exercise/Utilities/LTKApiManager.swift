//
//  LTKApiManager.swift
//  LTK-exercise
//

import Foundation

class LTKApiManager
{
    static var shared = LTKApiManager()
    
    private init() {}
    
    let urlString = API.feedUrl
    
    func getFeed(completion: @escaping (LTKFeed?)-> ())
    {
        guard let url = URL(string: urlString)
        else
        {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, res, err in
            if let data = data
            {
                do
                {
                    let remindersResponse: LTKFeed = try LTKFeed(data: data)
                    completion(remindersResponse)
                }
                catch let error
                {
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
            else
            {
                completion(nil)
            }
        }.resume()
    }
}







