//
//  Util.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class Util {
    
    static func decodeJSONData<T>(from urlString: String, type: T.Type) -> T? where T: Decodable {
        if let url = URL(string: urlString) {
            var T: T?
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        T = try JSONDecoder().decode(type, from: data)
                    } catch let error {
                        print(error.localizedDescription)
                        T = nil
                    }
                }
            }.resume()
            return T
        }
        return nil
    }
    
}
