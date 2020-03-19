//
//  DoodleImageManager.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

class DoodleImageManager {
    
    private var doodleImages: [DoodleImage]?
    var count: Int? {
        return doodleImages?.count
    }
    
    func decodeDoodleImagesJSONData() {
        
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImage].self,
                                   dateDecodingStrategy: .formatted(DateFormatter.yyyyMMdd)) { doodleImages in
                                if let doodleImages = doodleImages {
                                    self.doodleImages = doodleImages
                                }
        }
    }
    
}
