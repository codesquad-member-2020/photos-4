//
//  Network.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static func excuteURLSession(from urlString: String, completionHandler: @escaping (Data?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil
                else {
                    print(error!.localizedDescription)
                    return
            }
            guard let data = data else { return }
            completionHandler(data)
        }.resume()
    }
    
}
