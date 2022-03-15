//
//  CachedAsyncImage.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/03/22.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct CachedAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(url: URL, scale: CGFloat = 1, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cachedImage = ImageCache[url] {
            let _ = print("cached: \(url.absoluteString)")
            content(.success(cachedImage))
        } else {
            let _ = print("request: \(url.absoluteString)")
            AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                cacheAndrender(phase: phase)
            }
        }
    }
    
    func cacheAndrender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

struct ImageCache {
    static var cache: [URL : Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            return cache[url]
        }
        set {
            cache[url] = newValue
        }
    }
}

