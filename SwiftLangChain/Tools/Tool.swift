//
//  Tool.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

enum ToolError: Error {
    case invalidInput
}

protocol Tool {
    var name: String { get }
    var description: String { get }
    var enabled: Bool { get set }
    var finished: Bool { get }
    func run(args: String) throws -> String
}

let allTools: [Tool] = [SearchScheduleTool(), BookTrainTool(), FinishTool()]
