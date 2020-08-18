//
//  ImagesCollectionViewController.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 1.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UICollectionViewController{
    
    private let reuseId = "ImageCollectionViewCell"
    
    @IBOutlet var imagesCollectionView: UICollectionView!
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! ImageCollectionViewCell
        
        return cell
    }
}
