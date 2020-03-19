//
//  DoodleCell.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class DoodleCell: UICollectionViewCell, ReusableView {
    
    @IBOutlet weak var doodleImageView: UIImageView!
    
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
    }
    
}
