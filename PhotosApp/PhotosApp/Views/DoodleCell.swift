//
//  DoodleCell.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class DoodleCell: UICollectionViewCell, ReusableView {
    
    private var doodleImageView: UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPhoto(image: UIImage?) {
        guard let doodleImage = image
            else {
                return
        }
        doodleImageView.image = doodleImage
        contentView.addSubview(doodleImageView)
    }
    
}
