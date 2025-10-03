//
//  ArticleFeedView.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import SwiftUI
import FeedAppKit

public struct ArticleFeedViewData {
    let articles: [ArticleFeedEntryViewData]

    init(_ feed: ArticleFeedModel) {
        self.articles = feed.items.map(ArticleFeedEntryViewData.init)
    }
}

struct ArticleFeedEntryViewData: Identifiable {
    let id: ArticleDetailModel.ID
    let title: String
    let lastModified: String

    init(_ articleData: ArticleDetailModel) {
        self.title = articleData.title
        self.lastModified = "ciao"
        self.id = articleData.id
    }
}

public struct ArticleFeedView<Content: View>: View {
    public typealias ViewModel = ArticleFeedViewModel
    public typealias DetailViewProvider = (ArticleDetailModel.ID) -> Content
    @StateObject var viewModel: ViewModel
    @State private var path = NavigationPath()

    private var detailViewProvider: DetailViewProvider
    public init(viewModel: ViewModel, detailViewProvider: @escaping DetailViewProvider) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.detailViewProvider = detailViewProvider
    }

    public var body: some View {
        switch self.viewModel.state {
        case .error:
            Text("Error")
        case .loading:
            Text("Loading...")
                .task {
                    await self.viewModel.load()
                }
        case .loaded(let viewData):
            NavigationStack(path: $path) {
                List {
                    ForEach(viewData.articles) { article in
                        HStack {
                            Text(article.title)
                            Spacer()
                            Text(article.lastModified)
                        }.onTapGesture {
                            path.append(article.id)
                        }
                    }
                }
                .navigationDestination(for: ArticleDetailModel.ID.self) { id in
                    detailViewProvider(id)
                }
            }
        }
    }
}

// #if DEBUG
// #Preview("Article feed") {
//    ArticleFeedView(
//        viewModel: .init(
//            articleFeedService: MockArticleFeedService(
//                result: .success(
//                    ArticleFeedModel(title: "ciao", items: [.init(title: "title", url: URL(string: "test.com")!, dateModified:Date(), contentText: "ciao")])
//                )
//            )
//        )
//    )
// }
//
// #Preview("Error") {
//    ArticleFeedView(
//        viewModel: .init(
//            articleFeedService: MockArticleFeedService(
//                result: .failure(NSError(domain: "test", code: 0, userInfo: nil))
//            )
//        )
//    )
// }
//
// #Preview("Forever loading") {
//    ArticleFeedView(
//        viewModel: .init(
//            articleFeedService: MockArticleFeedService()
//        )
//    )
// }
//
// struct MockArticleFeedService: ArticleFeedServiceProtocol {
//    private let result: Result<ArticleFeedModel, any Error>
//    init(result: Result<ArticleFeedModel, any Error>) {
//        self.result = result
//        self.neverReturn = false
//    }
//    
//    private let neverReturn: Bool
//    init() {
//        self.result = .failure(NSError(domain: "test", code: 0, userInfo: nil))
//        self.neverReturn = true
//    }
//    
//    func fetchArticles() async -> Result<ArticleFeedModel, any Error> {
//        if self.neverReturn {
//            return await withCheckedContinuation { _ in }
//        }
//        else {
//            return result
//        }
//    }
// }
//
// #endif
