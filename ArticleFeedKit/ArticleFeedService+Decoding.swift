//
//  ArticleFeedService+Decoding.swift
//  Swift Feed
//
//  Created by André on 2025-10-02.
//

import Foundation
import FeedAppKit

protocol ArticleFeedDecodingServiceProtocol {
    func decode(_ data: Data) throws -> ArticleFeedModel?
}

struct ArticleFeedDecodingService: ArticleFeedDecodingServiceProtocol {
    func decode(_ data: Data) throws -> ArticleFeedModel? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let model = try decoder.decode(ArticleFeedModel.self, from: data)
        return model
    }
}
