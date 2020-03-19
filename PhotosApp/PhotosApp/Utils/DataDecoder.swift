//
//  DataDecoder.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class DataDecoder {
    
    static func decodeJSONData<T>(from urlString: String, type: T.Type, completion: @escaping (T?) -> ())
        where T: Decodable {
            Network.excuteURLSession(from: urlString) { (data) in
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
