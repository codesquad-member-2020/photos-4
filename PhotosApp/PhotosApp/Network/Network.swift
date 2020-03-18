//
//  Network.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class Network {
    
    static func excuteURLSession(from urlString: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: urlString)
            else {
                return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                completion(data)
            }
        }.resume()
    }
    
}
