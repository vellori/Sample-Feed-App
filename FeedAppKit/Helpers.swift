//
//  Helpers.swift
//  Swift Feed
//
//  Created by André on 2025-10-03.
//

import Foundation
#if DEBUG
public extension String {
    static var mockRandom: String {
        UUID().uuidString
    }

    static var mockShort: String {
        "Sample Short"
    }

    static var mockLong: String { // swiftlint:disable line_length
        "Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long Sample Long "
    }
}

public extension URL {
    static var mockDummy: URL {
        URL(string: "https://example.com")!
    }

    static var mockRandom: URL {
        URL(string: "https://example.com/\(UUID().uuidString)")!
    }

    static func mockNamed(_ num: Int) -> URL {
        URL(string: "https://example.com/\(num)")!
    }
}

public extension ArticleDetailModel {
    static var mockRandom: ArticleDetailModel {
        ArticleDetailModel(
            title: .mockRandom,
            url: .mockRandom,
            dateModified: Date.now,
            contentText: .mockRandom
        )
    }

    static var mockArticle1: ArticleDetailModel {
        ArticleDetailModel(
            title: "Article 1",
            url: .mockNamed(1),
            dateModified: Date.now,
            contentText: .mockLong
        )
    }
}

public class MockURLDownloaderService: URLDownloaderProtocol {
    private let mockData: Result<Data, Error>
    init(result: Result<Data, Error>) {
        self.mockData = result
    }

    var calledURL: URL?
    public func download(url: URL) async -> Result<Data, any Error> {
        self.calledURL = url
        return self.mockData
    }

}

enum MockError: Error {
    case generic
}
#endif
