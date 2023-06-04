//
//  SettingsView.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import SwiftUI
import OpenAI

struct SettingsKeys {
    static let openAI_API_key = "openAIAPIKey"
    static let OpenAIModelKey = "openAIModel"
}

struct SettingsView: View {
    @AppStorage(SettingsKeys.openAI_API_key) private var openAI_API_key = ""
    @AppStorage(SettingsKeys.OpenAIModelKey) private var openAIModel: String = Model.gpt3_5Turbo

    var body: some View {
        Form {
            TextField("OpenAI API Key:", text: $openAI_API_key)
            Picker("GPT Model:", selection: $openAIModel) {
                Text("GPT 3.5 Turbo").tag(Model.gpt3_5Turbo)
                Text("GPT 4").tag(Model.gpt4)
            }
        }
        .padding()
        .frame(minWidth: 450)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
