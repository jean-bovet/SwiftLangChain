//
//  BookTrainTool.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

final class BookTrainTool: Tool {
    var name = "book_train"
    var description = "Book a particular train. The input parameter is the train identifier"
    var enabled = true
    var finished = false

    func run(args: String) throws -> String {
        let regex = /book_train\[(\w+?)\]/
        if let result = try regex.wholeMatch(in: args) {
            return book_train(name: String(result.1))
        } else {
            throw ToolError.invalidInput
        }
    }

    func book_train(name: String) -> String {
        "\(name) booked for $47"
    }
}
