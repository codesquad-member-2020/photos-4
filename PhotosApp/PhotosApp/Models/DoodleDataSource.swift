//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class DoodleDataSource: NSObject, UICollectionViewDataSource {
    
    private var doodleImageInfos: [DoodleImageInfo]?
    private let doodleImageManager = DoodleImageManager()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImageInfos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            DoodleCell.reuseIdentifier, for: indexPath) as! DoodleCell
        if let doodleImageInfos = doodleImageInfos {
            let doodleImageInfo = doodleImageInfos[indexPath.item]
            doodleImageManager.downloadImage(urlString: doodleImageInfo.imageURLString) { image in
                doodleCell.setPhoto(image: image)
            }
        }
        return doodleCell
    }

    func decodeDoodleImagesJSONData() {
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy: .formatted(DateFormatter.yyyyMMdd)) { doodleImageInfos in
                                if let doodleImageInfos = doodleImageInfos {
                                    self.doodleImageInfos = doodleImageInfos
                                }
        }
    }
    
}
