//
//  ImagesCollectionViewController.swift
//  Image Gallery
//
//  Created by Kaloyan Simeonov on 1.06.20.
//  Copyright © 2020 Kaloyan Simeonov. All rights reserved.
//

import UIKit

class ImagesCollectionViewController: UICollectionViewController, UIDropInteractionDelegate {
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    private let itemMinimumWidth: CGFloat = 20.0
    
    private let reuseId = "ImageCollectionViewCell"
    
    var document: GalleryDocument?
    
    var isGallerySelected = false
    
    private var flowLayout: UICollectionViewFlowLayout? {
       return collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
     }
    
    var gallery: Gallery = Gallery() {
        didSet{
            if isViewLoaded {
                imagesCollectionView.reloadData()
            }
        }
    }
    
    var width: CGFloat = 200.0

    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.addInteraction(UIDropInteraction(delegate: self))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imagesCollectionView.dragInteractionEnabled = true
        document?.open() { success in
            if success {
                self.title = self.document?.localizedName
                self.gallery = self.document?.gallery ?? Gallery()
            }
            
        }
    
    }

    @IBOutlet var imagesCollectionView: UICollectionView! {
        didSet{
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinching(sender: )))
            imagesCollectionView.addGestureRecognizer(pinchGestureRecognizer)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ImageScrollViewController {
            let vc = segue.destination as? ImageScrollViewController
            let cell = sender as! ImageCollectionViewCell
            let index = imagesCollectionView.indexPath(for: cell)!.item
            let url = gallery.images[index].url
            vc?.url = url
        }
    }
    
    
    //MARK: -IBActions
    @IBAction func save(_ sender: UIBarButtonItem? = nil) {
        document?.gallery = gallery
        if document?.gallery != nil {
            document?.updateChangeCount(.done)
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        save()
        dismiss(animated: true) {
            self.document?.close()
        }
    }
    
    //MARK: -CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! ImageCollectionViewCell
        let data = gallery.images[indexPath.item]
        let url = data.url
        cell.imageView.loadImage(fromURL: url)
        
        return cell
    }
    
    
    
    //MARK: -Gesture Methods
    
    @objc func pinching(sender: UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            for cell in imagesCollectionView.visibleCells {
                cell.bounds.applying(CGAffineTransform(scaleX: sender.scale, y: sender.scale))
                cell.contentView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            }
        }
        width = imagesCollectionView.visibleCells.first?.contentView.frame.width as! CGFloat
    }
}

extension ImagesCollectionViewController {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }
  
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        var url: URL?
        var image: String?
        
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]
            image = ImageConverter.imageToBase64(images[0])
        }
        
        session.loadObjects(ofClass: URL.self, completion: { (items) in
            url = items[0].absoluteURL
            let indexPath = IndexPath(item: self.gallery.images.indices.last ?? 0, section: 0)
            self.gallery.addData(url: url ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/d2/Question_mark.svg")!, image: image!)
            
            self.imagesCollectionView.performBatchUpdates({
                self.imagesCollectionView.insertItems(at: [indexPath])
                })
        })
        
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = imagesCollectionView.cellForItem(at: indexPath)
        let height = cell?.frame.height ?? 200.0 * CGFloat(1.0)
        let size = CGSize(width: width, height: height)
        
        return size
    }
}

extension ImagesCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionIsRestrictedToDraggingApplication session: UIDragSession) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let image = gallery.images[sourceIndexPath.item]
        gallery.images.remove(at: sourceIndexPath.item)
        gallery.images.insert(image, at: destinationIndexPath.item)
    }
}
