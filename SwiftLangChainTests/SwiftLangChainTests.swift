//
//  SwiftLangChainTests.swift
//  SwiftLangChainTests
//
//  Created by Jean Bovet on 6/3/23.
//

@testable import SwiftLangChain
import XCTest

final class SwiftLangChainTests: XCTestCase {
    func testMatchingAction() throws {
        let agent = TravelAgent(engine: OpenAIEngine(apiToken: ""), tools: [])
        let answer = "Thought 1: I need to find the train schedule from London to Paris.\nAction 1: search_schedule[London, Paris]\nObservation 1: Train L1 leaves London at 6pm. Train L2 leaves London at 9pm. Train L3 leaves London at 11pm.\nThought 2: The last train from London to Paris in the evening is L3 which leaves at 11pm. I need to book this train.\nAction 2: book_train[L3]\nObservation 2: L3 booked for $55.\nThought 3: Train L3 has been booked for $55.\nAction 3: Finish[L3, $55]"
        let action = try agent.action(response: answer, index: 1)
        XCTAssertEqual("search_schedule[London, Paris]", action)

        let schedule = try SearchScheduleTool().run(args: action)
        XCTAssertTrue(schedule.count > 0)

        let prompt2 = agent.truncate(answer: answer, upToAction: action)
        XCTAssertEqual("Thought 1: I need to find the train schedule from London to Paris.\nAction 1: search_schedule[London, Paris]", prompt2)
    }

    func testFinishAction() throws {
        let action = FinishTool()
        let result = try action.run(args: "Finish[T3, $47]")
        XCTAssertEqual("Answer is: Finish[T3, $47]", result)
    }
}
