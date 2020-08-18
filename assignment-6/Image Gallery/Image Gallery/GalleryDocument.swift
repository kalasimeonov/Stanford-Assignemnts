//
//  Document.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 11.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class GalleryDocument: UIDocument {
    
    var gallery: Gallery?
    
    override func contents(forType typeName: String) throws -> Any {
        return gallery?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let json = contents as? Data {
            gallery = Gallery(json: json)
        }
    }
    
}

