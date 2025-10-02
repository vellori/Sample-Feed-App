//
//  AppEnvironment.swift
//  Swift Feed
//
//  Created by André on 2025-10-02.
//

import Foundation

enum AppEnvironment {
    static var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
            || NSClassFromString("XCTestCase") != nil
    }
}
