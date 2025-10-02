//
//  ArticleEntryViewModel.swift
//  Swift Feed
//
//  Created by André on 2025-09-30.
//

import Combine
import Foundation
import FeedAppKit

public class ArticleDetailViewModel: ObservableObject {

    enum State {
        case loaded(ArticleDetailViewData)
    }

    @Published var state: State
    public init(article: ArticleDetailModel) {
        self.state = .loaded(
            .init(article)
        )
    }
}
