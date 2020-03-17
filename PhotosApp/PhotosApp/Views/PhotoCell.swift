//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/17.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class PhotoCell: UICollectionViewCell {

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPhotoImageView()
    }
    
    private func setupPhotoImageView() {
        contentView.addSubview(photoImageView)
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
