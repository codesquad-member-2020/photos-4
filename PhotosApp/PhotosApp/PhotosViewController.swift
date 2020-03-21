//
//  ViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import Photos

final class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBAction func touchUpAddButton(_ sender: UIBarButtonItem) {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = DoodleCell.cellSize
            return layout
        }()
        let doodleViewController = DoodleViewController(collectionViewLayout: layout)
        let doodleNavigationController: UINavigationController = {
            let controller = UINavigationController(rootViewController: doodleViewController)
            controller.modalPresentationStyle = .fullScreen
            return controller
        }()
        self.present(doodleNavigationController, animated: true, completion: nil)
    }
    
    private let photosDataSource = PhotosDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard photosDataSource.isPhotoAuthorized(completionHandler: { isAuthorized in
            if isAuthorized {
                self.viewDidLoad()
            }
        }) else { return }
        photosDataSource.setupPhotos()
        setupPhotosCollectionView()
        photosCollectionView.reloadData()
        setObservers()
    }
    
    private func setupPhotosCollectionView() {
        photosCollectionView.dataSource = photosDataSource
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(forName: PhotosDataSource.notificationPhotoLibraryDidChange,
                                               object: photosDataSource,
                                               queue: nil) { [weak self] notification in
                                                self?.photoLibraryDidChange(notification)
        }
    }
    
}

extension PhotosViewController {
    
    private func photoLibraryDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let value = userInfo["changes"] else { return }
        let changes = value as! PHFetchResultChangeDetails<PHAsset>
        updateCollectionView(changes)
    }
    
    private func updateCollectionView(_ changes: PHFetchResultChangeDetails<PHAsset>) {
        if changes.hasIncrementalChanges {
            photosCollectionView.performBatchUpdates({
                if let removed = changes.removedIndexes, removed.count > 0 {
                    photosCollectionView.deleteItems(at: removed.map { IndexPath(item: $0,
                                                                                 section: photosDataSource.photosSectionIndex) })
                }
                if let inserted = changes.insertedIndexes, inserted.count > 0 {
                    photosCollectionView.insertItems(at: inserted.map { IndexPath(item: $0,
                                                                                  section: photosDataSource.photosSectionIndex) })
                }
                if let changed = changes.changedIndexes, changed.count > 0 {
                    photosCollectionView.reloadItems(at: changed.map { IndexPath(item: $0,
                                                                                 section: photosDataSource.photosSectionIndex) })
                }
                changes.enumerateMoves { [weak self] fromIndex, toIndex in
                    self?.photosCollectionView.moveItem(at: IndexPath(item: fromIndex,
                                                                      section: self?.photosDataSource.photosSectionIndex ?? 0),
                                                        to: IndexPath(item: toIndex,
                                                                      section: self?.photosDataSource.photosSectionIndex ?? 0))
                }
            })
        } else {
            photosCollectionView.reloadData()
        }
    }
    
}
