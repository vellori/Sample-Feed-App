//
//  ArticleFeedUseCases.swift
//  Swift Feed
//
//  Created by André on 2025-09-30.
//

import SwiftUI
import FeedAppKit

public extension UseCases {
    enum ArticleFeedUseCases {
        public typealias ArticleDetailViewProvider<T: View> = (ArticleDetailModel) -> T
        case landing
        @ViewBuilder
        public func view<Detail: View>(detailViewProvider: @escaping ArticleDetailViewProvider<Detail>)
        -> some View {
            let viewModel = ArticleFeedViewModel(
                articleFeedService: ArticleFeedService(
                    urlDownloader: URLDownloaderService(),
                    decodingService: ArticleFeedDecodingService()
                )
            )

            ArticleFeedView(viewModel: viewModel,
            detailViewProvider: { id in
                detailViewProvider(viewModel.item(id: id))
            })
        }
    }
}
