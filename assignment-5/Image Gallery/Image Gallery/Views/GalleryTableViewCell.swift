//
//  GalleryTableViewCell.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 3.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var galleryNameField: UITextField! {
        didSet{
            galleryNameField.backgroundColor = UIColor.clear
        }
    }
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        galleryNameField.delegate = self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapCell(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func doubleTapCell(_ sender: UIGestureRecognizer) {
        galleryNameField.isEnabled = true
    }
}

extension GalleryTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !galleryNameField.isEditing {
            textField.isEnabled = false
        }
    }
}
