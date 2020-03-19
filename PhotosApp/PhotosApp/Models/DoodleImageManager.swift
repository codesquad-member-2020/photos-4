//
//  DoodleImageManager.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class DoodleImageManager {
    
    func downloadImage(urlString: String, resultHandler: @escaping (UIImage?) -> ()) {
        Network.excuteURLSession(from: urlString) { (data) in
            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    resultHandler(image)
                }
            }
        }
    }
    
}
