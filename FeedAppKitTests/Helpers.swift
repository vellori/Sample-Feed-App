//
//  Helpers.swift
//  Swift Feed
//
//  Created by André on 2025-10-02.
//

import Foundation
@testable import FeedAppKit

extension String {
    static var random: String {
        UUID().uuidString
    }
}

extension URL {
    static var dummy: URL {
        URL(string: "https://example.com")!
    }
}

extension ArticleDetailModel {
    static var dummy: ArticleDetailModel {
        ArticleDetailModel(
            title: .random,
            url: URL.dummy,
            dateModified: Date.now,
            contentText: .random
        )
    }
}
