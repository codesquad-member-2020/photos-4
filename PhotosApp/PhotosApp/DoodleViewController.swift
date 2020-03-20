//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

enum URLInfo {
    
    static let addressAboutDoodleDatas = "https://public.codesquad.kr/jk/doodle.json"
    
}

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
        doodleDataSource.setupPhotos {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        setupCollectionView()
        setNavigationBar()
        setupGestureRecognizer()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = doodleDataSource
        collectionView.register(DoodleCell.self, forCellWithReuseIdentifier:
        DoodleCell.reuseIdentifier)
        collectionView.backgroundColor = .darkGray
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(touchUpCloseButton))
    }
    
    @objc func touchUpCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showMenuItem))
        longPressGestureRecognizer.minimumPressDuration = 0.5
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func showMenuItem(gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self.collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
        indexPathOfPressedCell = indexPath
        guard let pressedCell = collectionView.cellForItem(at: indexPath) else { return }
        let menuItem = UIMenuItem(title: "Save", action: #selector(saveImage))
        UIMenuController.shared.menuItems = [menuItem]
        UIMenuController.shared.showMenu(from: pressedCell, rect: pressedCell.contentView.frame)
        pressedCell.becomeFirstResponder()
    }
    
    @objc func saveImage() {
        
    }
    
}
