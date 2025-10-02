//
//  ArticleEntryUseCases.swift
//  Swift Feed
//
//  Created by André on 2025-09-30.
//

import SwiftUI
import FeedAppKit

extension UseCases {
    public enum ArticleDetail {
        public struct Default {
            public init() {}
            public static func make(article: ArticleDetailModel) -> some View {
                ArticleDetailView(
                    viewModel: .init(article: article)
                )
            }
        }
    }
}
