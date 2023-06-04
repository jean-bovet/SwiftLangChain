//
//  ContentView.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var question = "Book the last train from London to Paris in the evening."
    @State private var output = ""
    @State private var running = false
    @ObservedObject var model: AppModel

    var agent: AgentModel {
        model.agents.first!
    }

    var body: some View {
        HStack {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        TextField("Enter your question", text: $question)
                        Button("Submit") {
                            output = ""
                            running = true
                            executeAgent()
                        }
                    }.disabled(running)
                    if running {
                        ProgressView()
                            .progressViewStyle(.linear)
                    }
                }

                ScrollView {
                    Text("\(output)")
                        .textSelection(.enabled)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            }

            VStack {
                Picker("Agent:", selection: $model.agentId) {
                    ForEach(model.agents, id: \.self) { agent in
                        Text(agent.name).tag(agent.id as UUID?)
                    }
                }

                ToolsView(agent: agent)
            }
        }
        .padding()
    }

    func executeAgent() {
        guard let agent = agent.agent else {
            displayError(message: "Unable to create the agent")
            return
        }
        Task {
            do {
                _ = try await agent.run(prompt: question) { output, finished in
                    DispatchQueue.main.async {
                        self.output += "\n\n" + output
                        self.running = !finished
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    displayError(message: "Execution error: \(error)")
                }
            }
        }
    }
    
    func displayError(message: String) {
        output = message
        running = false
    }
}

struct ToolsView: View {
    @ObservedObject var agent: AgentModel

    var body: some View {
        Table($agent.tools) {
            TableColumn("Name") { tool in
                Toggle("\(tool.wrappedValue.tool.name)", isOn: tool.enabled)
                    .disabled(tool.wrappedValue.tool.finished)
            }

            TableColumn("Description") { tool in
                Text(tool.tool.wrappedValue.description)
                    .disabled(tool.wrappedValue.tool.finished)
            }.width(min: 350)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AppModel())
    }
}
