//
//  Effort.swift
//  HeavyLogCoreData
//
//  Created by Sebastian Staszczyk on 14/08/2021.
//

import Foundation

public struct Effort {
    let exerciseId: Int
    let exercise: ExerciseEntity
    let sets: [WorkoutSet]

    init(exercise: ExerciseEntity, sets: [WorkoutSet] = []) {
        self.exercise = exercise
        self.exerciseId = exercise.id_
        self.sets = sets
    }
}