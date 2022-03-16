//
//  BuisnessDetailContentView.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 16/03/22.
//

import Foundation
import SwiftUI

struct BuisnessDetailContentView: View {
    @ObservedObject var buisnessViewModel: HeadlinesViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 5, content: {
            HeaderView {
                MultiColorText("^[\(getHeaderString().uppercased())](multiColor: 'extreme')")
            }
            List(buisnessViewModel.articles) { article in
                NavigationLink(destination: WebView(url: URL(string: article.url ?? "")), label: {
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text(article.title ?? "").title().padding(5)
                        Text(article.description ?? "").description().padding(5)
                    })
                })
            }
        }).navigationViewStyle(StackNavigationViewStyle()).navigationBarTitleDisplayMode(.inline)
    }
    
   @MultiLineString func getHeaderString() -> String {
        " Buisness News "
       "(Enjoy Reading)"
    }
}

//MARK: View Builder
struct HeaderView<Content: View> : View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content.padding(5).foregroundColor(Color.blue).font(.system(size: 16))
        }.padding(5).frame(width: 320, height: 64, alignment: .center)
        
    }
}

//MARK: Result Builder
@resultBuilder struct MultiLineString {
    static func buildBlock(_ parts: String...) -> String {
        parts.joined(separator: "\n")
    }
}
