//
//  ArticleEntryView.swift
//  Swift Feed
//
//  Created by André on 2025-09-30.
//

import SwiftUI
import FeedAppKit

struct ArticleDetailViewData: Identifiable {
    let id: ArticleDetailModel.ID

    let title: String
    let content: String
    let lastModified: String
    let url: URL

    init(_ articleData: ArticleDetailModel) {
        self.title = articleData.title
        self.lastModified = String(localized: "last modified")
        self.content = articleData.contentText
        self.url = articleData.url

        self.id = articleData.id
    }
}

public struct ArticleDetailView: View {
    public typealias ViewModel = ArticleDetailViewModel
    public init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    @Environment(\.openURL) private var openURL
    @StateObject var viewModel: ViewModel

    public var body: some View {
        switch self.viewModel.state {
        case .loaded(let data):
            List {
                Text(data.title)
                    .font(.largeTitle)
                Text(data.content)
                    .font(.body)
                Button("Open") {
                    self.openURL(data.url)
                }
            }
        }
    }
}
