//
//  DoodleImageManager.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

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
    
    func downloadImages() {
        guard let doodleImages = doodleImages
            else {
            return
        }
        var index = 0
        doodleImages.forEach { doodleImage in
            Network.excuteURLSession(from: doodleImage.imageURLString) { (data) in
                if let imageData = data {
                    self.doodleImageDatas[index] = imageData
                }
            }
            index += 1 
        }
    }

}
