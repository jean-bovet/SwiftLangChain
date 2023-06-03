//
//  SettingsView.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import SwiftUI

struct SettingsKeys {
    static let openAI_API_key = "openAIAPIKey"
}

struct SettingsView: View {
    @AppStorage(SettingsKeys.openAI_API_key) private var openAI_API_key = ""

    var body: some View {
        Form {
            TextField("OpenAI API Key:", text: $openAI_API_key)
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
