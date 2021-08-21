//
//  ExerciseData.swift
//  HeavyLogCoreData
//
//  Created by Sebastian Staszczyk on 07/08/2021.
//

import Foundation

public struct ExerciseData {
    let id: Int
    let name: String
    let shortName: String?
    let information: String?
    let difficulty: Difficulty
    let type: ExerciseType
    let mainBodyPart: BodyPart
    let additionalBodyParts: [BodyPart]?
}

extension ExerciseData: Decodable {

    enum CodingKeys: String, CodingKey {
        case id, name, information, difficulty, type
        case shortName = "short_name"
        case mainBodyPart = "main_body_part"
        case additionalBodyParts = "additional_body_parts"
    }
}

// MARK: - Sample Data

public extension ExerciseData {
    static let sampleBenchPress = ExerciseData(id: -1, name: "Bench press", shortName: nil, information: "An upper-body weight training exercise in which the trainee presses a weight upwards while lying on a weight training bench.", difficulty: .hard, type: .push, mainBodyPart: .chest, additionalBodyParts: [.anteriorDeltoid, .medialDeltoid, .triceps])
    
    static let sampleClassicDeadlift = ExerciseData(id: -2, name: "Classic deadlift", shortName: "CDL", information: "It is one of the three powerlifting exercises, along with the squat and bench press.", difficulty: .hard, type: .pull, mainBodyPart: .glutes, additionalBodyParts: [.lowerBack, .traps, .hamstrings])
}
