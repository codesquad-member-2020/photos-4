//
//  DoodleImage.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/18.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

struct DoodleImage: Codable {
    
    private let order: String
    private let date: Date
    private let imageURL: URL
    var imageURLString: String {
        return imageURL.absoluteString
    }
    
    enum CodingKeys: String, CodingKey {
        case order = "title"
        case imageURL = "image"
        case date
    }
    
}

extension DateFormatter {
    
    static let yyyyMMdd : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
}
