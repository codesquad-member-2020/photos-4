//
//  DoodleImage.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct DoodleImage: Codable {
    
    private let order: Int
    private let imageURL: URL
    private let date: Date
        
    enum CodingKeys: String, CodingKey {
        case order = "title"
        case imageURL = "image"
        case date
    }
    
}


