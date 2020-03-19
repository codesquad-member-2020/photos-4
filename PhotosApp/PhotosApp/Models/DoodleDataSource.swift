//
//  DoodleDataSource.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class DoodleDataSource: NSObject, UICollectionViewDataSource {
    
    private var doodleImageInfos = [DoodleImageInfo]()
    private var doodleCells = [DoodleCell]()
    private var doodleImages = [UIImage]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.notificationDoodleImageDidChange,
                                            object: nil)
        }
    }
    
    private let doodleImageManager = DoodleImageManager()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("doodleImageInfos?.count: \(String(describing: doodleImageInfos.count))")
        return doodleImageInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier:
            DoodleCell.reuseIdentifier, for: indexPath) as! DoodleCell
        print("doodleImages.count: \(doodleImages.count)")
        print("indexPath.item: \(indexPath.item)")
        doodleCells.append(doodleCell)
        return doodleCell
    }
    
    func setupPhotos(resultHandler: @escaping () -> ()) {
        decodeDoodleImagesJSONData { doodleImageInfos in
            resultHandler()
            var index = 0
            doodleImageInfos?.forEach({
                self.doodleImageManager.downloadImage(urlString: $0.imageURLString) { image in
                    if let image = image {
                        DispatchQueue.main.async {
                            self.doodleCells[index].setPhoto(image: image)
                        }
                    }
                }
            })
            index += 1
        }
    }
    
    
    private func decodeDoodleImagesJSONData(resultHandler: @escaping ([DoodleImageInfo]?) -> ()) {
        DataDecoder.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                   type: [DoodleImageInfo].self,
                                   dateDecodingStrategy: .formatted(DateFormatter.yyyyMMdd)) { doodleImageInfos in
                                    if let doodleImageInfos = doodleImageInfos {
                                        self.doodleImageInfos = doodleImageInfos
                                        resultHandler(doodleImageInfos)
                                    }
        
        }
    }
    
}
