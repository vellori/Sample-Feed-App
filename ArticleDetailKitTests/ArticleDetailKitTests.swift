//
//  ArticleDetailKitTests.swift
//  ArticleDetailKitTests
//
//  Created by André on 2025-09-30.
//

import Testing
import Foundation
@testable import ArticleDetailKit
@testable import FeedAppKit

struct ArticleDetailKitTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test func testArticleDetailState() async throws {
        let article = ArticleDetailModel.dummy
        let sut = ArticleDetailViewModel(article: article)
        switch sut.state {
        case .loaded(let loadedArticle):
            #expect(article.title == loadedArticle.title)
            #expect(article.id == loadedArticle.id)
            #expect(article.contentText == loadedArticle.content)
            #expect(article.url == loadedArticle.url)
        }
    }

}
