//
//  ViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let photosDataSource = PhotosDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        if isPhotoAuthorized() {
            photosDataSource.requestPhotos()
        }
        
        collectionView.register(PhotoCell.self,
                                forCellWithReuseIdentifier: ReuseIdentifier.photosCell)
        collectionView.dataSource = photosDataSource
        collectionView.reloadData()
    }
    
    private func isPhotoAuthorized() -> Bool {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            return true
        case .notDetermined:
            var isAuthorized = false
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    isAuthorized = true
                default:
                    isAuthorized = false
                }
            })
            return isAuthorized
        default:
            return false
        }
    }

}
