//
//  ImageCache.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 11/02/22.
//

/*
import Foundation
import UIKit.UIImage

public protocol ImageCacheType: AnyObject {
    func insertImage(image: UIImage?, for url: URL)
    func image(for url:URL) -> UIImage?
    func removeImage(for url: URL)
    func removeAllImages()
    subscript (_ url: URL) -> UIImage? { get set }
}

public final class ImageCache: ImageCacheType {

    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024*1024*100)
    }

    let config: Config
    let lock = NSLock()

    init(config: Config = Config.defaultConfig) {
        self.config = config
    }

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()

    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let decodedCache = NSCache<AnyObject, AnyObject>()
        decodedCache.totalCostLimit = config.memoryLimit
        return decodedCache
    }()


    public func insertImage(image: UIImage?, for url: URL) {

        guard let image = image else {
            removeImage(for: url)
            return
        }
        let decompressedImage = image.decodedImage()
        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decompressedImage, forKey: url as AnyObject)
        decodedImageCache.setObject(image, forKey: url as AnyObject,  cost: decompressedImage.diskSize)

    }

    public func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return  decodedImage
        }

        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }

    public func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }

    public func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }

    public subscript(url: URL) -> UIImage? {
        get {
            image(for: url)
        }
        set {
            insertImage(image: newValue, for: url)
        }
    }

}

extension UIImage {
    var diskSize: Int {
        guard  let cgImage = cgImage else {
            return 0
        }
        return cgImage.bytesPerRow * cgImage.height
    }

    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else {
            return self
        }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let color = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: color, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else {
            return self
        }
        return UIImage(cgImage: decodedImage)
    }
}
*/
