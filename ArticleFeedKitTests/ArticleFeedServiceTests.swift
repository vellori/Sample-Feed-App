//
//  ArticleFeedServiceTests.swift
//  Swift Feed
//
//  Created by André on 2025-10-03.
//

import Testing
import Foundation
@testable import ArticleFeedKit
@testable import FeedAppKit

struct ArticleFeedServiceTests {
    @Test func testSuccessScenario() async {
        guard let data = "ciao".data(using: .utf16) else {
            Issue.record("Can't serialise string into data")
            return
        }
        let downloaderService = MockURLDownloaderService(result: .success(data))
        let decodingService = ArticleFeedDecodingServiceProtocolMock()
        decodingService.decodeClosure = { someData in
            #expect(someData == data)
            return ArticleFeedModel(title: "Test", items: [])
        }
        let sut = ArticleFeedService(urlDownloader: downloaderService, decodingService: decodingService)
        let result = await sut.fetchArticles()
        switch result {
        case .success(let model):
            #expect(model.title == "Test")
            #expect(model.items.count == 0)
        default:
            Issue.record("Wrong result in deconding")
        }

    }

    @Test func testGenericFailureDecodingScenario() async {
        guard let data = "ciao".data(using: .utf16) else {
            Issue.record("Can't serialise string into data")
            return
        }
        let downloaderService = MockURLDownloaderService(result: .success(data))
        let decodingService = ArticleFeedDecodingServiceProtocolMock()
        decodingService.decodeClosure = { someData in
            #expect(someData == data)
            return nil
        }
        let sut = ArticleFeedService(urlDownloader: downloaderService, decodingService: decodingService)
        let result = await sut.fetchArticles()
        switch result {
        case .failure(let error):
            #expect((error as? ArticleFeedService.Error) == ArticleFeedService.Error.generic)
        default:
            Issue.record("Wrong result in deconding")
        }
    }

    @Test func testDownloadingFailureScenario() async {
        let downloaderService = MockURLDownloaderService(result: .failure(ArticleFeedService.Error.malformedURL))
        let decodingService = ArticleFeedDecodingServiceProtocolMock()
        decodingService.decodeClosure = { _ in return nil}
        let sut = ArticleFeedService(urlDownloader: downloaderService, decodingService: decodingService)
        let result = await sut.fetchArticles()
        switch result {
        case .failure(let error):
            #expect((error as? ArticleFeedService.Error) == ArticleFeedService.Error.malformedURL)
        default:
            Issue.record("Wrong result in deconding")
        }
    }
}
