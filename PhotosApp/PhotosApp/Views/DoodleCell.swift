//
//  DoodleCell.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class DoodleCell: UICollectionViewCell, ReusableView {
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private var doodleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDoodleImageView()
        displaySaveMenuItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDoodleImageView()
        displaySaveMenuItem()
    }
    
    func setupDoodleImageView() {
        addSubview(doodleImageView)
        doodleImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        doodleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        doodleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        doodleImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setPhoto(image: UIImage?) {
        guard let doodleImage = image
            else {
                return
        }
        doodleImageView.image = doodleImage
    }
    
    func displaySaveMenuItem() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self.contentView, action: #selector(cellDidTap))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        self.contentView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func cellDidTap() {
        let menuItem = UIMenuItem(title: "Save", action: #selector(saveDidTap))
        UIMenuController.shared.menuItems = [menuItem]
        UIMenuController.shared.showMenu(from: self, rect: self.contentView.frame)
        self.contentView.becomeFirstResponder()
    }
    
    @objc func saveDidTap() {
        
    }
    
}
