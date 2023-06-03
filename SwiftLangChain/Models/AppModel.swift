//
//  AppModel.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

final class AppModel: ObservableObject {
    @Published var output = ""
    @Published var agents = [AgentModel]()
    @Published var agentId: UUID? = nil

    init() {
        agents.append(AgentModel())
        agentId = agents.first?.id
    }
}
