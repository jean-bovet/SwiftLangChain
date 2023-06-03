//
//  ToolModel.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

final class ToolModel: ObservableObject, Identifiable {
    let id = UUID()
    var tool: Tool
    var enabled = true

    init(tool: Tool) {
        self.tool = tool
    }
}
