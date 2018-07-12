//
//  ViewController.swift
//  WoloxCoreMlTest
//
//  Created by Juanfra on 05/05/2018.
//  Copyright © 2018 Juanfra. All rights reserved.
//

import UIKit
import Vision
import CoreML

enum PaintStyles: Int {
    static var count = 6
    
    case scream = 0
    case candy
    case feathers
    case laMuse
    case mosaic
    case udnie
    
    public static var all: [PaintStyles] {
        var caseIndex: Int = 0
        let interator: AnyIterator<PaintStyles> = AnyIterator {
            let result = PaintStyles(rawValue: caseIndex)
            caseIndex += 1
            return result
        }
        return Array(interator)
    }
}

class ViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    @IBOutlet weak var toConvertImage: UIImageView!
    @IBOutlet weak var imagesCarrousel: UICollectionView!

    var chosenImage: UIImage!
    var processedImages: [UIImage?] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        toConvertImage.isUserInteractionEnabled = true
        toConvertImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCameraButton(sender:))))
    
        self.imagesCarrousel.register(StyleCarrouselCell.self, forCellWithReuseIdentifier: "StyleCarrouselCell")
        self.imagesCarrousel.register(UINib(nibName: "StyleCarrouselCell", bundle: nil), forCellWithReuseIdentifier: "StyleCarrouselCell")

        chosenImage = UIImage(named: "lens.jpeg")!
        toConvertImage.image = chosenImage
        updateCarrousel()
        imagesCarrousel.delegate = self
        imagesCarrousel.dataSource = self
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        toConvertImage.image = image
        updateCarrousel()
        dismiss(animated:true, completion: nil)
    }
    
    private func updateCarrousel() {
        processedImages = convertToStyles(image: toConvertImage.image!)
        imagesCarrousel.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PaintStyles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleCarrouselCell", for: indexPath) as! StyleCarrouselCell
        
        // Configure the cell
        if processedImages.count > indexPath.row {
            cell.image.image = processedImages[indexPath.row]
        }else {
            cell.image.image = .none
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return chosenImage.size
    }
    
    
    
    func convertToStyles(image: UIImage) -> [UIImage?] {
        var images: [UIImage?] = []
        
        for style in PaintStyles.all {
            let converted: UIImage?
            switch style {
                case .candy: converted = FNS_Candy_1().style(image: image)
                case .feathers: converted = FNS_Feathers_1().style(image: image)
                case .laMuse: converted = FNS_La_Muse_1().style(image: image)
                case .mosaic: converted = FNS_Mosaic_1().style(image: image)
                case .scream: converted = FNS_The_Scream_1().style(image: image)
                case .udnie: converted = FNS_Udnie_1().style(image: image)
            }
            images.append(converted)
        }
        
        return images
    }
    
}

