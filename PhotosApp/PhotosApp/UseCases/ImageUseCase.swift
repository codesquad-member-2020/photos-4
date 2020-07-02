//
//  ImageUseCase.swift
//  PhotosApp
//
//  Created by kimdo2297 on 2020/05/01.
//  Copyright © 2020 jinie. All rights reserved.
//

import Foundation

final class ImageUseCase {
    static func imageData(from urlString: String, number: Int, completionHandler: @escaping (Data?) -> (Void)) {
        guard let imageURL = URL(string: urlString),
            let destinaionURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(String(number)) else { return }
        
        if let imageData = try? Data(contentsOf: destinaionURL) {
            completionHandler(imageData)
        } else {
            Self.downloadImageData(requestURL: imageURL, destinationURL: destinaionURL) { imageData in
                guard let imageData = imageData else { return }
                completionHandler(imageData)
            }
        }
    }
    
    private static func downloadImageData(requestURL: URL, destinationURL: URL,
                                          completionHandler: @escaping (Data?) -> ()) {
        URLSession.shared.downloadTask(with: requestURL) { (tempURL, urlResponse, error) in
            guard let tempURL = tempURL else { return }
            try? FileManager.default.moveItem(at: tempURL, to: destinationURL)
            guard let imageData = try? Data(contentsOf: destinationURL) else { return }
            completionHandler(imageData)
        }.resume()
    }
}
