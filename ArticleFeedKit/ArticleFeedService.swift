//
//  ArticleFeedService.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import Foundation
import FeedAppKit

public protocol ArticleFeedServiceProtocol {
    func fetchArticles() async -> Result<ArticleFeedModel, Error>
}

struct ArticleFeedService: ArticleFeedServiceProtocol {
    let urlDownloader: URLDownloaderProtocol
    let decodingService: ArticleFeedDecodingServiceProtocol
    
    func fetchArticles() async -> Result<ArticleFeedModel, Swift.Error> {
        guard let url = URL(string: "https://www.macstories.net/feed/json/") else {
            return .failure(Error.malformedURL)
        }
        let networkResult = await Task.detached {
            return await urlDownloader.download(url: url)
        }.value
        
        switch networkResult {
        case .success(let data):
            do {
                if let model = try decodingService.decode(data) {
                    return .success(model)
                }
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
        return .failure(Error.generic)
    }
}

extension ArticleFeedService {
    enum Error: Swift.Error {
        case malformedURL
        case generic
    }
}
