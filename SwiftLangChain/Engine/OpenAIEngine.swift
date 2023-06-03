//
//  OpenAIEngine.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation
import OpenAI

final class OpenAIEngine: AIEngine {
    let apiToken: String
    var messages = [Chat]()

    init(apiToken: String) {
        self.apiToken = apiToken
        messages.append(.init(role: .system, content: "You are a travel agent"))
    }

    func ask(prompt: String) async throws -> String? {
        messages.append(.init(role: .user, content: prompt))
        let openAI = OpenAI(apiToken: apiToken)
        let query = ChatQuery(model: .gpt3_5Turbo,
                              messages: messages,
                              temperature: 0)
        let result = try await openAI.chats(query: query)
        guard let response = result.choices.first?.message.content else {
            // TODO: throw
            return nil
        }

        return response
    }
}
