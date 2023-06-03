//
//  AgentModel.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

final class AgentModel: ObservableObject, Identifiable, Hashable, Equatable {
    static func == (lhs: AgentModel, rhs: AgentModel) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()
    let name = "Travel Agent"

    @Published var tools = [ToolModel]()

    var agent: TravelAgent? {
        guard let token = UserDefaults.standard.string(forKey: SettingsKeys.openAI_API_key) else {
            return nil
        }
        return TravelAgent(engine: OpenAIEngine(apiToken: token), tools: tools.filter(\.enabled).map(\.tool))
    }

    init() {
        tools = allTools.map { ToolModel(tool: $0) }
    }
}
