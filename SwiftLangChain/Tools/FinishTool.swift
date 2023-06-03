//
//  FinishTool.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

final class FinishTool: Tool {
    var name = "Finish"
    var description = "A tool that detects the end of the reasoning"
    var enabled = true
    var finished = true

    func run(args: String) throws -> String {
        let regex = /Finish\[(.+?)\]/
        if let result = try regex.wholeMatch(in: args) {
            return "Answer is: \(result.0)"
        } else {
            throw ToolError.invalidInput
        }
    }
}
