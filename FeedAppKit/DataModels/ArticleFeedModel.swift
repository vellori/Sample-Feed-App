//
//  ArticleFeedModel.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import Foundation

public struct ArticleFeedModel: Decodable {
    public init(title: String, items: [ArticleDetailModel]) {
        self.title = title
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case items
    }
    public let title: String
    public let items: [ArticleDetailModel]
}
