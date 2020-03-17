//
//  ViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photosCollectionView: UICollectionView!
    private let photosDataSource = PhotosDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard photosDataSource.isPhotoAuthorized()
            else {
            return
        }
        photosDataSource.setupPhotos()
        photosDataSource.sharePhotoLibraryChanges()
        setupPhotosCollectionView()
        photosCollectionView.reloadData()
    }
    
    
    
    private func setupPhotosCollectionView() {
        photosCollectionView.register(PhotoCell.self,
                                      forCellWithReuseIdentifier: ReuseIdentifier.photosCell)
        photosCollectionView.dataSource = photosDataSource
    }
    
}
