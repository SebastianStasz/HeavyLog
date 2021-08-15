//
//  EffortEntityTests.swift
//  HeavyLogTests
//
//  Created by Sebastian Staszczyk on 14/08/2021.
//

import XCTest
@testable import HeavyLog

class EffortEntityTests: XCTestCase, CoreDataSteps {

    var context = PersistenceController.preview.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.preview.context
    }

    override func tearDownWithError() throws {

    }

    // MARK: - Tests

    func test_create_effort_entity() throws {
        // Before creating there should not be any efforts.
        try fetchRequestShouldReturnElements(0, for: EffortEntity.self)

        // Create exercise entity.
        let exercise = try createExerciseEntity(data: .sampleBenchPress)

        // Create effort data.
        let effortData = Effort(exercise: exercise)

        // Create workout entity using sample1 data.
        let workout = createWorkoutEntity(data: .sample1)

        // Create effort entity using sample1 data.
        let effort = try createEffortEntity(in: workout, data: effortData)

        // After creating there should be one effort.
        try fetchRequestShouldReturnElements(1, for: EffortEntity.self)

        // Verify that effort entity data is correct.
        try verifyEffortEntityData(effort, data: effortData, workout: workout)
    }

    func test_edit_effort_entity() throws {
        // Create workout entity using sample1 data.
        let workout = createWorkoutEntity(data: .sample1)

        // Create exercise entity.
        let exercise = try createExerciseEntity(data: .sampleBenchPress)

        // Create effort data.
        let effortData = Effort(exercise: exercise)

        // Create effort entity using sample1 data.
        let effort = try createEffortEntity(in: workout, data: effortData)

        // Create exercise2 entity.
        let exercise2 = try createExerciseEntity(data: .sampleClassicDeadlift)

        // Create effort data 2.
        let effortData2 = Effort(exercise: exercise2)

        // Modify effort entity using sample2 data.
        effort.modify(effort: effortData2)

        // Verify that data has been changed.
        try verifyEffortEntityData(effort, data: effortData2, workout: workout)
    }

    func test_delete_effort_entity() throws {
        // Create workout entity using sample1 data.
        let workout = createWorkoutEntity(data: .sample1)

        // Create exercise entity.
        let exercise = try createExerciseEntity(data: .sampleBenchPress)

        // Create effort entity using sample1 data.
        let effort = try createEffortEntity(in: workout, data: .init(exercise: exercise))

        // Verify that effort entity was created.
        try fetchRequestShouldReturnElements(1, for: EffortEntity.self)

        // Delete effort entity
        effort.delete()

        // Verify that effort entity was deleted.
        try fetchRequestShouldReturnElements(0, for: EffortEntity.self)

        // Verify that workout relatet to this entity still exist.
        try fetchRequestShouldReturnElements(1, for: WorkoutEntity.self)

        // Verify that workout relatet to this entity has no efforts.
        try workoutEffortsCountIsEqual(workout: workout, 0)
    }
}

// MARK: - Steps

extension EffortEntityTests {

    private func verifyEffortEntityData(_ effort: EffortEntity, data: Effort, workout: WorkoutEntity) throws {
        XCTAssertEqual(effort.workout, workout)
    }

    private func workoutEffortsCountIsEqual(workout: WorkoutEntity, _ amount: Int) throws {
        XCTAssertEqual(workout.efforts.count, amount)
    }
}
