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

    static var random: URL {
        URL(string: "https://example.com/\(UUID().uuidString)")!
    }
}

extension ArticleDetailModel {
    static var random: ArticleDetailModel {
        ArticleDetailModel(
            title: .random,
            url: .random,
            dateModified: Date.now,
            contentText: .random
        )
    }
}

class MockURLDownloaderService: URLDownloaderProtocol {
    private let mockData: Result<Data, Error>
    init(result: Result<Data, Error>) {
        self.mockData = result
    }

    var calledURL: URL?
    func download(url: URL) async -> Result<Data, any Error> {
        self.calledURL = url
        return self.mockData
    }

}

enum MockError: Error {
    case generic
}
