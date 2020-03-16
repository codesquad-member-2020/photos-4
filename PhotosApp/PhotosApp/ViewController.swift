//
//  ViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/16.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let photosDataSource = PhotosDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photosDataSource
        collectionView.reloadData()
    }

}

