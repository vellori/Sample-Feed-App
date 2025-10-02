//
//  URLDownloaderService.swift
//  Swift Feed
//
//  Created by André on 2025-09-29.
//

import Foundation

public protocol URLDownloaderProtocol {
    func download(url: URL) async -> Result<Data, Error>
}

public struct URLDownloaderService: URLDownloaderProtocol {
    public init() {}
    
    public func download(url: URL) async -> Result<Data, Error> {
        do {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let data = try await URLSession.shared.data(for: request).0
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
