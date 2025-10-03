//
//  ArticleEntryModel.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import Foundation

public struct ArticleDetailModel: Decodable, Identifiable {
    public init(title: String, url: URL, dateModified: Date, contentText: String) {
        self.title = title
        self.url = url
        self.dateModified = dateModified
        self.contentText = contentText
    }
    
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
