//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by jinie on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class DoodleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        processJSONData(from: URLInfo.addressAboutDoodleDatas)
    }

    private func processJSONData(from urlString: String) {
        
    }
    
}

enum URLInfo {
    
    static let addressAboutDoodleDatas = "https://public.codesquad.kr/jk/doodle.json"
    
}
