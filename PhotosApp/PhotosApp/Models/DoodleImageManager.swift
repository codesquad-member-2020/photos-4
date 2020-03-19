//
//  DoodleImageManager.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class DoodleImageManager {
    

    private var doodleImages: [DoodleImageInfo]?
    var doodleImageDatas = [Data]()
    var count: Int? {
        return doodleImages?.count
    }
    
    func decodeDoodleImagesJSONData() {
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy: .formatted(DateFormatter.yyyyMMdd)) { doodleImages in
                                if let doodleImages = doodleImages {
                                    self.doodleImages = doodleImages
                                }
        }
    }
    
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
