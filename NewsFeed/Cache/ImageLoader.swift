//
//  ImageLoader.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 11/02/22.
//

/*
import Foundation
import UIKit.UIImage
import Combine

public class ImageLoader {
    
    static let shared = ImageLoader()
    private let cache: ImageCacheType
    
    init(cache: ImageCacheType = ImageCache()) {
        self.cache = cache
    }
    
    private lazy var backgroundQueue: OperationQueue = {
       let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        return operationQueue
    }()
    
    public func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let cacheImage = cache[url] {
            return Just(cacheImage).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url).map( { (data, response) -> UIImage? in
            return UIImage(data: data)
        }).catch( {error in
            Just(nil)
        }).handleEvents(receiveOutput: { [unowned self] image in
            guard let image = image else { return }
            self.cache[url] = image
        }).subscribe(on: backgroundQueue).receive(on: RunLoop.main).eraseToAnyPublisher()

    }
}
*/
