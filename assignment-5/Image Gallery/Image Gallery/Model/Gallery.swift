//
//  Gallery.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 3.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import Foundation

class Gallery {
    
    //MARK: -Properties
    var images: [ImageData] = []
    var title: String?
    
    var count: Int {
      return images.count
    }
    
    //MARK: -Types
    struct ImageData {
      var url: URL
      var aspectRatio: Double
    }
    
    //MARK: -Inits
    init(_ images: [ImageData] = [], title: String? = nil) {
        self.images = images
        self.title = title
    }
    
}

