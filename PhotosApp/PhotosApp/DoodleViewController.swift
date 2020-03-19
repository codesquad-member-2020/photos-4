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
        collectionView.register(DoodleCell.self, forCellWithReuseIdentifier:
            DoodleCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = doodleDataSource
        setupDoodleViewController()
        collectionView.reloadData()
    }
    
    private func setupDoodleViewController() {
        view.backgroundColor = .darkGray
        navigationItem.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(touchUpCloseButton))
    }
    
    @objc func touchUpCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
