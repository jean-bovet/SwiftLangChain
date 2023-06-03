//
//  AIEngine.swift
//  SwiftLangChain
//
//  Created by Jean Bovet on 6/3/23.
//

import Foundation

protocol AIEngine {
    func ask(prompt: String) async throws -> String?
}
