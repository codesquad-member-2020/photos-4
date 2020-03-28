//
//  DoodleCell.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    static let yyyyMMdd : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
}

final class DoodleCell: UICollectionViewCell, ImageColletcionCell, ReusableView {
    
    static var cellSize = CGSize(width: 110, height: 50)

    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private var doodleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDoodleImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDoodleImageView()
    }
    
    func setupDoodleImageView() {
        addSubview(doodleImageView)
        doodleImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        doodleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        doodleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        doodleImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setPhoto(image: UIImage?) {
        guard let doodleImage = image else { return }
        doodleImageView.image = doodleImage
    }
    
}
