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

    @IBOutlet weak var photosCollectionView: UICollectionView!
    private let photosDataSource = PhotosDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard photosDataSource.isPhotoAuthorized()
            else {
            return
        }
        photosDataSource.setupPhotos()
        setupPhotosCollectionView()
        photosCollectionView.reloadData()
    }
    
    private func setupPhotosCollectionView() {
        photosCollectionView.dataSource = photosDataSource
    }
    
}

extension ViewController: PhotosDataSourceDelegate {
    
    func allPhotosDidChange(changes: PHFetchResultChangeDetails<PHAsset>) {
        if changes.hasIncrementalChanges {
            photosCollectionView.performBatchUpdates({
                if let removed = changes.removedIndexes, removed.count > 0 {
                    photosCollectionView.deleteItems(at: removed.map { IndexPath(item: $0, section: photosDataSource.photosSectionIndex) })
                }
                if let inserted = changes.insertedIndexes, inserted.count > 0 {
                    photosCollectionView.insertItems(at: inserted.map { IndexPath(item: $0, section: photosDataSource.photosSectionIndex) })
                }
                if let changed = changes.changedIndexes, changed.count > 0 {
                    photosCollectionView.reloadItems(at: changed.map { IndexPath(item: $0, section: photosDataSource.photosSectionIndex) })
                }
                changes.enumerateMoves { [weak self] fromIndex, toIndex in
                    self?.photosCollectionView.moveItem(at: IndexPath(item: fromIndex, section: self?.photosDataSource.photosSectionIndex ?? 0),
                                                        to: IndexPath(item: toIndex, section: self?.photosDataSource.photosSectionIndex ?? 0))
                }
            })
        } else {
            photosCollectionView.reloadData()
        }
    }
    
}
