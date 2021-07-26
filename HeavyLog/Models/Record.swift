//
//  Record.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 24/07/2021.
//

import SwiftUI

struct Record {
    let exerciseName: String
    let value: Double
    let date: Date
    let reps: Reps

    var numberOfReps: String {
        reps.indicator
    }

    var valueStr: String {
        String(value)
    }

    var color: Color {
        reps.color
    }

    var colorLight: Color {
        reps.colorLight
    }
}

extension Record: Hashable {}

// MARK: - Sample Data

extension Record {
    static let sampleSquatX1 = Record(exerciseName: "Squat", value: 140, date: Date(), reps: .one)
    static let sampleSquatX3 = Record(exerciseName: "Squat", value: 125, date: Date(), reps: .three)
    static let sampleSquatX5 = Record(exerciseName: "Squat", value: 115, date: Date(), reps: .five)
    static let sampleDeadliftX1 = Record(exerciseName: "Deadlift", value: 195, date: Date(), reps: .one)
    static let sampleDeadliftX3 = Record(exerciseName: "Deadlift", value: 175, date: Date(), reps: .three)
    static let sampleDeadliftX5 = Record(exerciseName: "Deadlift", value: 160, date: Date(), reps: .five)
    static let sampleBenchPressX1 = Record(exerciseName: "Bench Press", value: 115, date: Date(), reps: .one)
    static let sampleBenchPressX3 = Record(exerciseName: "Bench Press", value: 105, date: Date(), reps: .three)
    static let sampleBenchPressX5 = Record(exerciseName: "Bench Press", value: 100, date: Date(), reps: .five)
}
