//
//  MultiColorText.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/03/22.
//

import SwiftUI
import Foundation

@available(iOS 15, *)
struct MultiColorText: View {
    
    var attributedString: AttributedString
    var font: Font = .system(size: 14.0)
    
    static var colors: [MutliColorAttribute.Value : [Color]] = [
        .general : [.red, . green, .blue],
        .extreme : [.red, .yellow, .green, .blue, .orange, .pink, .black]
    ]
    
    var body: some View {
        Text(attributedString).font(font)
    }
    
    init(withAttributedString attributedString: AttributedString) {
        self.attributedString = MultiColorText.annotateAttributedString(attributedString: attributedString)
    }
    
    init(_ localizedKey: String.LocalizationValue) {
        attributedString = MultiColorText.annotateAttributedString(
            attributedString: AttributedString(localized: localizedKey, including: \.topHeadlinesApp))
    }
    
    static func annotateAttributedString(attributedString: AttributedString) -> AttributedString {
        var attrString = attributedString
       
        for run in attrString.runs {
            guard let multiColormode = run.multiColor else {
                continue
            }
            let currentRange = run.range
            var index = currentRange.lowerBound
            let colors: [Color] = colors[multiColormode]!
            var counter: Int = 0
            while index < currentRange.upperBound {
                let nextIndex = attrString.characters.index(index, offsetBy: 1)
                attrString[index ..< nextIndex].foregroundColor = colors[counter]
                counter += 1
                if counter >= colors.count {
                    counter = 0
                }
                index = nextIndex
            }
        }
        return attrString
    }
}

@available(iOS 15, *)
extension AttributeScopes {
    struct MultiColorAttributes: AttributeScope {
        let multiColor: MutliColorAttribute
    }
    
    var topHeadlinesApp: MultiColorAttributes.Type { MultiColorAttributes.self }
}

@available(iOS 15, *)
extension AttributeDynamicLookup {
    subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.MultiColorAttributes, T>) -> T {
        self[T.self]
    }
}

enum MutliColorAttribute: DecodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
    enum Value: String, Codable, Hashable {
        case general
        case extreme
    }
    
    static var name = "multiColor"
}

