//
//  ImageOverlayContentView.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/03/22.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct ImageOverlayContentView: View {
    
    @Binding var showImage: Bool
    var image: Image
    
    var body: some View {
        ZStack {
            Color(.systemBackground).opacity(0.1).ignoresSafeArea().onTapGesture {
                withAnimation{
                    showImage.toggle()
                }
            }
            RoundedRectangle(cornerRadius: 5.0).border(.gray, width: 2.0).foregroundColor(.white).overlay(
                image.resizable().aspectRatio(contentMode: .fit).padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2))
            ).frame(width: 250, height: 250, alignment: .center)
        }
    }
}

