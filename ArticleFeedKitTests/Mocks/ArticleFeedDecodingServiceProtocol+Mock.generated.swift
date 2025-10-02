// Generated using Sourcery 2.3.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
@testable import FeedAppKit
@testable import Swift_Feed
@testable import ArticleFeedKit

class ArticleFeedDecodingServiceProtocolMock: ArticleFeedDecodingServiceProtocol {

    //MARK: - decode

    var decodeThrowableError: Error?
    var decodeCallsCount = 0
    var decodeCalled: Bool {
        return decodeCallsCount > 0
    }
    var decodeReceivedData: Data?
    var decodeReceivedInvocations: [Data] = []
    var decodeReturnValue: ArticleFeedModel?
    var decodeClosure: ((Data) throws -> ArticleFeedModel?)?

    func decode(_ data: Data) throws -> ArticleFeedModel? {
        if let error = decodeThrowableError {
            throw error
        }
        decodeCallsCount += 1
        decodeReceivedData = data
        decodeReceivedInvocations.append(data)
        return try decodeClosure.map({ try $0(data) }) ?? decodeReturnValue
    }

}
