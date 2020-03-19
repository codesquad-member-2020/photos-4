//
//  DateFormatter.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/03/19.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let yyyyMMdd : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
    
}
