//
//  Gallery.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 3.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation

struct Gallery: Codable {
    
    //MARK: -JSON Data
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    //MARK: -Properties
    var images: [ImageData] = []
    var title: String
    
    var count: Int {
      return images.count
    }
    
    //MARK: -Types
    struct ImageData: Codable {
      var url: URL
      var image: String
    }
    
    //MARK: -Functions
    
    mutating func addData(url: URL, image: String) {
        images.append(Gallery.ImageData(url: url, image: image))
    }
    
    //MARK: -Inits
    init(_ images: [ImageData] = [], title: String = "Untitled") {
        self.images = images
        self.title = title
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Gallery.self, from: json) {
            self = newValue
        } else {
            return nil
        }
    }
    
}

