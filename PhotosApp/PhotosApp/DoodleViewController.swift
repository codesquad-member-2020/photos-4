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

final class DoodleViewController: UIViewController {

    private var doodleImages: [DoodleImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeDoodleImagesJSONData()
    }
    
    private func decodeDoodleImagesJSONData() {
        guard let doodles = Util.decodeJSONData(from: URLInfo.addressAboutDoodleDatas,
                                                type: [DoodleImage].self)
            else {
                return
        }
        doodleImages = doodles
    }
    
}
