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
    
    private var doodleImages: [DoodleImage]?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeDoodleImagesJSONData()
        setupDoodleViewController()
    }
    
    @objc func touchUpCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupDoodleViewController() {
        view.backgroundColor = .darkGray
        navigationItem.title = "Doodles"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(touchUpCloseButton))
    }
    
    private func decodeDoodleImagesJSONData() {
        Util.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                            type: [DoodleImage].self) { doodleImages in
                                if let doodleImages = doodleImages {
                                    self.doodleImages = doodleImages
                                }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodleImages?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let doodleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "doodleCell", for: indexPath)
        return doodleCell
    }
    
}
