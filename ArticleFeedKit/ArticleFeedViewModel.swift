//
//  ArticleFeedViewModel.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import Foundation
import Combine
import FeedAppKit

protocol ArticleFeedViewModelProtocol {
    var state: ArticleFeedViewModel.State { get }
    func load() async
}

public class ArticleFeedViewModel: ObservableObject {
    private let articleFeedService: ArticleFeedServiceProtocol
    private var data: Model?
    @Published var state: State
    
    init(articleFeedService: any ArticleFeedServiceProtocol) {
        self.articleFeedService = articleFeedService
        self.state = .loading
    }
    
    func load() async {
        let result = await self.articleFeedService.fetchArticles()
        switch result {
        case .success(let model):
            self.data = model
            self.state = .loaded(.init(model))
        default:
            self.state = .error(Error.badServerResponse)
        }
    }
    
    func item(id: ArticleDetailModel.ID) -> DetailModel {
        let result = self.data?.items.first(where: { $0.id == id })
        guard let result else {
            fatalError()
        }
        return result
    }
}

extension ArticleFeedViewModel {
    public typealias Model = ArticleFeedModel
    public typealias DetailModel = ArticleDetailModel
    typealias ViewData = ArticleFeedViewData
    
    enum State {
        case loading
        case loaded(ViewData)
        case error(Error)
    }
    
    enum Error: Swift.Error {
        case badServerResponse
    }
}
