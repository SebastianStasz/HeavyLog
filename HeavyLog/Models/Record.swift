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

    var dateStr: String {
        "\(date)"
    }

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
    static let squatX1 = Record(exerciseName: "Squat", value: 140, date: Date(), reps: .one)
    static let squatX3 = Record(exerciseName: "Squat", value: 125, date: Date(), reps: .three)
    static let squatX5 = Record(exerciseName: "Squat", value: 115, date: Date(), reps: .five)
    static let deadliftx1 = Record(exerciseName: "Deadlift", value: 195, date: Date(), reps: .one)
}
