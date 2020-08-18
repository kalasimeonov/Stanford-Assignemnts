//
//  ImageView.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 4.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ImageConverter {
    
    static func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }
    
    static func imageToBase64(_ image: UIImage) -> String? {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
    
}

extension UIImageView {
    
    public func loadImage(fromURL url: URL) {
        let cache =  URLCache.shared
        let request = URLRequest(url: url)
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = self.center
        ai.startAnimating()
        self.addSubview(ai)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ai.removeFromSuperview()
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    public func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
}


