//
//  BuisnessHeadlinesContentView.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 16/03/22.
//

import SwiftUI
import Foundation

@available(iOS 15.0, *)
struct BuisnessHeadlinesContentView: View {
    
    @State var searchText: String = ""
    @StateObject var buisnessArticle = HeadlinesViewModel()
    
    var body: some View {
        //uncomment for rotataion animation
        /* NavigationView {
         VStack {
         GeometryReader { outerView in
         List(ArticleSearchResult(searchText: searchText, articleModel: buisnessArticle).result, id: \.self) { title in
         GeometryReader { geo in
         Text(title)
         //.rotation3DEffect(.degrees(geo.frame(in: .global).minY - outerView.size.height/2) / 5, axis: (x:0, y: 1, z: 0))
         }.frame(height: 100)
         }
         .searchable(text: $searchText).task {
         await buisnessArticle.loadData(apiType: .buisnessHeadlines)
         }
         }.dynamicTypeSize(.xSmall...(.large))
         .navigationTitle("Buisness Headlines")
         
         }
         }.dynamicTypeSize(.xSmall...(.xLarge))
         */
        
        NavigationView {
            
            VStack {
                List(ArticleSearchResult(searchText: searchText, articleModel: buisnessArticle).result, id: \.self) { title in
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text(title).listRowSeparator(.hidden)
                        Divider().padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                    }).listRowSeparator(.hidden)
                }
                .searchable(text: $searchText).task {
                    await buisnessArticle.loadData(apiType: .buisnessHeadlines)
                    
                }.dynamicTypeSize(.xSmall...(.large))
                    .navigationTitle("Buisness Headlines")
            }
        }.dynamicTypeSize(.xSmall...(.xLarge))
    }
    
    var searchResult: [String] {
        if searchText.isEmpty {
            return buisnessArticle.articles.map{
                $0.title ?? ""
            }
        } else {
            return buisnessArticle.articles.map{
                $0.title ?? ""
            }.filter{
                $0.contains(searchText)
            }
        }
    }
}

@available(iOS 15.0, *)
struct BuisnessHeadlinesContentView_Previews: PreviewProvider {
    static var previews: some View {
        BuisnessHeadlinesContentView()
    }
}


struct ArticleSearchResult {
    var searchText: String
    var articleModel: HeadlinesViewModel
    
    var result: [String] {
        get {
            let res = getSearchResult()
            return res
        }
    }
    
    func getSearchResult() -> [String] {
        if searchText.isEmpty {
            return articleModel.articles.map{
                $0.title ?? ""
            }
        } else {
            return articleModel.articles.map{
                $0.title ?? ""
            }.filter{
                $0.contains(searchText)
            }
        }
    }
}

