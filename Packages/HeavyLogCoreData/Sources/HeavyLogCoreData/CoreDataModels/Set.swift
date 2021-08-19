//
//  Set.swift
//  HeavyLogCoreData
//
//  Created by Sebastian Staszczyk on 15/08/2021.
//

import Foundation

public struct WorkoutSet {
    let reps: Int
    let weight: Double
}

// MARK: - Sample data

public extension WorkoutSet {
    static let sample1 = WorkoutSet(reps: 10, weight: 50)
    static let sample2 = WorkoutSet(reps: 5, weight: 100)
    static let sample3 = WorkoutSet(reps: 1, weight: 200)
}