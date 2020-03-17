//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/17.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    static let identifier = "photoCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setPhoto(image: UIImage?) {
        guard let photoImage = image
            else {
            return
        }
        photoImageView.image = photoImage
    }
    
}
