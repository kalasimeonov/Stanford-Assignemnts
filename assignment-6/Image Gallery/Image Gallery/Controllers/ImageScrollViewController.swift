//
//  ImageScrollViewController.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 9.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var url: URL?
    
    private let minimumZoomScale: CGFloat = 0.1
    private let maximumZoomScale: CGFloat = 3.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        splitViewController?.presentsWithGesture = false
        
        if url != nil {
            imageView.loadImage(fromURL: url!)
            DispatchQueue.main.async {
                self.imageView.sizeToFit()
                self.scrollView.contentSize = self.imageView.frame.size
                self.scrollView.minimumZoomScale = self.minimumZoomScale
                self.scrollView.maximumZoomScale = self.maximumZoomScale
                self.scrollView.bringSubviewToFront(self.imageView)
            }
        }
    }
}
extension ImageScrollViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
    

