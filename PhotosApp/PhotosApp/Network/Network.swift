//
//  Network.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

final class Network {
    
    static func excuteURLSession(from urlString: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil
                else {
                    print(error!.localizedDescription)
                    return
            }
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
    
}
