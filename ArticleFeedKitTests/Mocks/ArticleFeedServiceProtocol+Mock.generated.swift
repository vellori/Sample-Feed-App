// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
@testable import FeedAppKit
@testable import Swift_Feed
@testable import ArticleFeedKit

class ArticleFeedServiceProtocolMock: ArticleFeedServiceProtocol {

    //MARK: - fetchArticles

    var fetchArticlesCallsCount = 0
    var fetchArticlesCalled: Bool {
        return fetchArticlesCallsCount > 0
    }
    var fetchArticlesReturnValue: Result<ArticleFeedModel, Error>!
    var fetchArticlesClosure: (() -> Result<ArticleFeedModel, Error>)?

    func fetchArticles() -> Result<ArticleFeedModel, Error> {
        fetchArticlesCallsCount += 1
        return fetchArticlesClosure.map({ $0() }) ?? fetchArticlesReturnValue
    }

}
