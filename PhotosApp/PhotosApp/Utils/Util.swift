//
//  Util.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class Util {
    
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
    
    static func decodeJSONData<T>(from urlString: String, type: T.Type, completion: @escaping (T?) -> ())
        where T: Decodable {
            excuteURLSession(from: urlString) { (data) in
                if let data = data {
                    do {
                        let T = try JSONDecoder().decode(T.self, from: data)
                        completion(T)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
    }
    
}
