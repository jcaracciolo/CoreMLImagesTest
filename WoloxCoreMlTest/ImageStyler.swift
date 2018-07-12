//
//  ImageStyler.swift
//  WoloxCoreMlTest
//
//  Created by Juanfra on 06/05/2018.
//  Copyright © 2018 Juanfra. All rights reserved.
//

import UIKit

protocol ImageStyler {
    func style(image: UIImage) -> UIImage?
}

extension FNS_Candy_1: ImageStyler {
    func style(image: UIImage) -> UIImage? {
        if let pixelBuffer = image.pixelBuffer(width: 720, height: 720),
            let prediction = try? prediction(inputImage: pixelBuffer)  {
            return prediction.outputImage.uiImage()?.resize(size: image.size)
        }
        return .none
    }
}

extension FNS_Udnie_1: ImageStyler {
    func style(image: UIImage) -> UIImage? {
        if let pixelBuffer = image.pixelBuffer(width: 720, height: 720),
            let prediction = try? prediction(inputImage: pixelBuffer)  {
            return prediction.outputImage.uiImage()?.resize(size: image.size)
        }
        return .none
    }
}

extension FNS_Mosaic_1: ImageStyler {
    func style(image: UIImage) -> UIImage? {
        if let pixelBuffer = image.pixelBuffer(width: 720, height: 720),
            let prediction = try? prediction(inputImage: pixelBuffer)  {
            return prediction.outputImage.uiImage()?.resize(size: image.size)
        }
        return .none
    }
}

extension FNS_La_Muse_1: ImageStyler {
    func style(image: UIImage) -> UIImage? {
        if let pixelBuffer = image.pixelBuffer(width: 720, height: 720),
            let prediction = try? prediction(inputImage: pixelBuffer)  {
            return prediction.outputImage.uiImage()?.resize(size: image.size)
        }
        return .none
    }
}

extension FNS_Feathers_1: ImageStyler {
    func style(image: UIImage) -> UIImage? {
        if let pixelBuffer = image.pixelBuffer(width: 720, height: 720),
            let prediction = try? prediction(inputImage: pixelBuffer)  {
            return prediction.outputImage.uiImage()?.resize(size: image.size)
        }
        return .none
    }
}

extension FNS_The_Scream_1: ImageStyler {
    func style(image: UIImage) -> UIImage? {
        if let pixelBuffer = image.pixelBuffer(width: 720, height: 720),
            let prediction = try? prediction(inputImage: pixelBuffer)  {
            return prediction.outputImage.uiImage()?.resize(size: image.size)
        }
        return .none
    }
}
