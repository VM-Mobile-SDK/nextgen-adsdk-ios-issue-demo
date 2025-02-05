//
//  DemoApp.swift
//  nextgen-adsdk-ios-issue-demo
//
//  Created by Virtual Minds GmbH on 03.02.2025.
//  Copyright © 2024 Virtual Minds GmbH. All rights reserved.
//

import SwiftUI

@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
            }
            .navigationViewStyle(.stack)
        }
    }
}
