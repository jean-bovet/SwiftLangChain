//
//  SwiftLangChainApp.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import SwiftUI

@main
struct SwiftLangChainApp: App {
    @StateObject private var model = AppModel()

    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
        #if os(macOS)
            Settings {
                SettingsView()
            }
        #endif
    }
}
