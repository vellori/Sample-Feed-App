// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
@testable import FeedAppKit
@testable import Swift_Feed
@testable import ArticleFeedKit

class ArticleFeedViewModelProtocolMock: ArticleFeedViewModelProtocol {
    var state: ArticleFeedViewModel.State {
        get { return underlyingState }
        set(value) { underlyingState = value }
    }
    var underlyingState: ArticleFeedViewModel.State!

    //MARK: - load

    var loadCallsCount = 0
    var loadCalled: Bool {
        return loadCallsCount > 0
    }
    var loadClosure: (() -> Void)?

    func load() {
        loadCallsCount += 1
        loadClosure?()
    }

}
