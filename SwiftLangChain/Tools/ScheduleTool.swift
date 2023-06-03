//
//  ScheduleTool.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

final class SearchScheduleTool: Tool {
    var name = "search_schedule"
    var description = "Search for a particular train schedule. The input parameters are the starting city and the destination city"
    var enabled = true
    var finished = false

    func run(args: String) throws -> String {
        let regex = /search_schedule\[(\w+?), (\w+?)\]/
        if let result = try regex.wholeMatch(in: args) {
            return find_schedule(from: String(result.1), to: String(result.2))
        } else {
            throw ToolError.invalidInput
        }
    }

    func find_schedule(from: String, to: String) -> String {
        """
        Train IC1 from \(from) to \(to): 10am.
        Train IC2 from \(from) to \(to): 1pm.
        Train IC3 from \(from) to \(to): 8pm.
        """
    }
}
