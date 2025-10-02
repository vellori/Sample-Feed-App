//
//  Swift_FeedApp.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import SwiftUI
import FeedAppKit
import ArticleDetailKit
import ArticleFeedKit
import FeedDesignKit

@main
struct SwiftFeedApp: App {
    var body: some Scene {
        WindowGroup {
            if AppEnvironment.isRunningTests {
                Text("Running Tests")
            } else {
                Text(String(localized: "ciaoaoaoao"))
                UseCases
                    .ArticleFeedUseCases
                    .landing
                    .view(
                        detailViewProvider: { article in
                            UseCases.ArticleDetail.Default.make(article: article)
                        }
                    )
            }
        }
    }
}
