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
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupCollectionView()
        setupDoodleViewController()
        setObservers()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = doodleDataSource
        collectionView.backgroundColor = .white
        collectionView.register(DoodleCell.self, forCellWithReuseIdentifier:
        DoodleCell.reuseIdentifier)
    }
    
    private func setupDoodleViewController() {
        view.backgroundColor = .darkGray
        navigationItem.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(touchUpCloseButton))
    }
    
    @objc func touchUpCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DoodleViewController {
    
    private func setObservers() {
        NotificationCenter.default.addObserver(forName:
                                               DoodleDataSource
                                                .notifiactionDoodleImageInfosDidChange,
                                               object: doodleDataSource,
                                               queue: nil) { [weak self] _ in
                                                self?.reloadCollectionView()
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

