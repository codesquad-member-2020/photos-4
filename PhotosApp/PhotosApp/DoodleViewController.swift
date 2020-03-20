//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class DoodleViewController: UICollectionViewController {
    
    private let doodleDataSource = DoodleDataSource()
    private var indexPathOfPressedCell: IndexPath?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setNavigationBar()
        setupGestureRecognizer()
        setObservers()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = doodleDataSource
        collectionView.register(DoodleCell.self,
                                forCellWithReuseIdentifier: DoodleCell.reuseIdentifier)
        collectionView.backgroundColor = .darkGray
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(touchUpCloseButton))
    }
    
    @objc func touchUpCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                      action: #selector(showMenuItem))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func showMenuItem(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self.collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: location)
            else {
                return
        }
        indexPathOfPressedCell = indexPath
        guard let pressedCell = collectionView.cellForItem(at: indexPath)
            else {
                return
                
        }
        let menuItem = UIMenuItem(title: "Save", action: #selector(savePhoto))
        UIMenuController.shared.menuItems = [menuItem]
        UIMenuController.shared.showMenu(from: pressedCell, rect: pressedCell.contentView.frame)
        pressedCell.becomeFirstResponder()
    }
    
    @objc func savePhoto() {
        guard let indexPath = indexPathOfPressedCell else { return }
        let pressedCell = collectionView.cellForItem(at: indexPath) as! DoodleCell
        if let photo = pressedCell.photo() {
            UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
        }
    }
    
}


extension DoodleViewController {
    
    private func setObservers() {
        NotificationCenter.default.addObserver(forName: DoodleDataSource.notifiactionDoodleImageInfosDidChange,
                                               object: doodleDataSource,
                                               queue: nil) { [weak self] _ in
                                                DispatchQueue.main.async {
                                                    self?.reloadCollectionView()
                                                }
        }
    }
    
    private func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
}
