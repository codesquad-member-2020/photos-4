//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/17.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell, ImageColletcionCell, ReusableView {
    
    static var cellSize = CGSize(width: 100, height: 100)
    
    @IBOutlet weak var photoImageView: UIImageView!

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
