//
//  ArticleEntryModel.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import Foundation

public struct ArticleDetailModel: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case title, url, dateModified, contentText
    }

    public var id: String {
        self.url.absoluteString
    }

    public let title: String
    public let url: URL
    public let dateModified: Date
    public let contentText: String
}
