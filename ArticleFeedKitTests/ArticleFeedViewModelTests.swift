//
//  ArticleFeedViewModelTests.swift
//  Swift Feed
//
//  Created by André on 2025-10-02.
//

import Testing
@testable import ArticleFeedKit
@testable import FeedAppKit

struct ArticleFeedViewModelTests {

    @Test func testLoadingOnInitAndError() async {
        let urlDownloader = MockURLDownloaderService(result: .failure(MockError.generic))
        let decodingService = ArticleFeedDecodingServiceProtocolMock()
        let mockFeedService = ArticleFeedService(
            urlDownloader: urlDownloader, decodingService: decodingService
        )
        let sut = ArticleFeedViewModel(articleFeedService: mockFeedService)
        switch sut.state {
        case .loading:
            break
        default:
            Issue.record("Wrong state on init")
        }

        await sut.load()
        switch sut.state {
        case .error(let error):
            #expect(error == .badServerResponse)
        default:
            Issue.record("Wrong state")
        }
    }

    @Test func testLoadedState() async {
        let article1 = ArticleDetailModel.random
        let article2 = ArticleDetailModel.random
        let article3 = ArticleDetailModel.random

        let feedService = ArticleFeedServiceProtocolMock()
        feedService.fetchArticlesReturnValue = .success(
            .init(title: .random, items: [article1, article2, article3])
        )

        let sut = ArticleFeedViewModel(articleFeedService: feedService)
        await sut.load()

        switch sut.state {
        case .loaded(let model):
            #expect(model.articles.count == 3)
            #expect(model.articles[0].id == article1.id)
            #expect(model.articles[1].id == article2.id)
            #expect(model.articles[2].id == article3.id)
            #expect(model.articles[0].title == article1.title)
            #expect(model.articles[1].title == article2.title)
            #expect(model.articles[2].title == article3.title)
        default:
            Issue.record("Wrong article passed on select")
        }

        let article4 = sut.item(id: article2.id)
        print(article2)
        print(article4)
        #expect(article4 == article2)
    }

}

extension ArticleDetailModel: @retroactive Equatable {
    public static func == (lhs: ArticleDetailModel, rhs: ArticleDetailModel) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.contentText == rhs.contentText
    }
}
