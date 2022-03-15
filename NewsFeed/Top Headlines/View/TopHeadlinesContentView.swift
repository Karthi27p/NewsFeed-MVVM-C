//
//  TopHeadlinesContentView.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/03/22.
//

import SwiftUI

struct TopHeadlinesContentView: View {
    
    @StateObject var articleModel = TopHeadlinesViewModel()
    @State var showImage = false
    @Uppercased var titleText = "welcome & enjoy reading"
    
    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack {
                VStack  {
                    MultiColorText("^[\(titleText)](multiColor: 'extreme')")
                    
                    NavigationView {
                        GeometryReader { outerView in
                            List(articleModel.articles) { article in
                                VStack {
                                    GeometryReader { geo in
                                        NavigationLink(destination: WebView(url: URL(string: article.url!)!), label: {
                                            
                                            HStack(alignment: .top, spacing: 5, content: {
                                                
                                                CachedAsyncImage(url: URL(string: article.urlToImage ?? "") ?? URL(string: "https://techcrunch.com/wp-content/uploads/2022/03/perlego-team.jpg?w=764")!) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        ProgressView()
                                                    case .success(let image):
                                                        image.resizable()
                                                    case .failure(_):
                                                        ProgressView()
                                                    @unknown default:
                                                        ProgressView()
                                                    }
                                                }.frame(width: 100, height: 100).onTapGesture {
                                                    withAnimation{
                                                        articleModel.selectedArticle = article
                                                        showImage.toggle()
                                                    }
                                                }
                                                VStack(alignment: .leading, content: {
                                                    Text(article.title ?? "").title()
                                                    Text(article.description ?? "").description()
                                                })
                                            })
                                                .scaleEffect(getScaleEffectValue(outerFrame: outerView.frame(in: .global).minY, minY:  geo.frame(in: .global).minY))
                                            
                                            
                                        })
                                        
                                    }.frame(height: 100)
                                    Divider().padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                }.listRowSeparator(.hidden)
                                
                                
                            }.refreshable {
                                await articleModel.loadData(apiType: .techCrunch)
                            }.navigationBarTitle("TechCrunch News").task {
                                await articleModel.loadData(apiType: .techCrunch)
                            }
                        }
                    }
                }
                if showImage {
                    ImageOverlayContentView(showImage: $showImage, image: ImageCache[URL(string: (articleModel.selectedArticle?.urlToImage) ?? "")!] ?? Image(uiImage: UIImage(named: "PlaceholderImage")!))
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    // Get scale value to perform animation at top
    func getScaleEffectValue(outerFrame: CGFloat, minY: CGFloat) -> CGFloat {
        withAnimation(.easeOut(duration: 1)) {
            let scaleValue = (minY-15) / outerFrame
            if scaleValue > 1 {
                return 1
            } else {
                return scaleValue
            }
        }
    }
}

//MARK: Title View Modifier
struct BoldTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.black)
    }
}

//MARK: Description View Modifier
struct Description: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 14)).foregroundColor(.blue).lineLimit(2)
    }
}

//MARK: Extension
extension View {
    func title() -> some View {
        modifier(BoldTitle())
    }
    
    func description() -> some View {
        modifier(Description())
    }
}

//MARK: Property wrapper
@propertyWrapper struct Uppercased {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.uppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.uppercased()
    }
}

//MARK: Preview
struct TopHeadlinesContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopHeadlinesContentView()
    }
}

