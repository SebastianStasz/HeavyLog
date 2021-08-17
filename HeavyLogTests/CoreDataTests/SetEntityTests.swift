//
//  SetEntityTests.swift
//  HeavyLogTests
//
//  Created by Sebastian Staszczyk on 15/08/2021.
//

import XCTest
@testable import HeavyLog

class SetEntityTests: XCTestCase, CoreDataSteps {

    var context = PersistenceController.preview.context

    override func setUpWithError() throws {
        context.reset()
        context = PersistenceController.preview.context
    }

    // MARK: - Tests

    func test_create_set_entity() throws {
        // Before creating, there should not be any workout sets.
        try fetchRequestShouldReturnElements(0, for: SetEntity.self)

        // Create effort entity, that will be used to create set entity.
        let effortEntity = try createEffortEntity(workoutData: .sample1, exerciseData: .sampleBenchPress, setsData: [])

        // Create set entity.
        let setEntity = try createSetEntity(in: effortEntity, setData: .sample1)

        // After creating there should be one set.
        try fetchRequestShouldReturnElements(1, for: SetEntity.self)

        // Verify that set entity data is correct.
        try verifySetEntityData(set: setEntity, effort: effortEntity, setData: .sample1)
    }

    func test_edit_set_entity() throws {
        // Create effort entity, that will be used to create set entity.
        let effortEntity = try createEffortEntity(workoutData: .sample1, exerciseData: .sampleBenchPress, setsData: [])

        // Create set entity using sample1 data.
        let setEntity = try createSetEntity(in: effortEntity, setData: .sample1)

        // Define modified set data.
        let modifiedSetData = WorkoutSet.sample2

        // Modify set entity using sample2 data.
        setEntity.modify(setData: modifiedSetData)

        // Verify that data has been changed.
        try verifySetEntityData(set: setEntity, effort: effortEntity, setData: modifiedSetData)
    }

    func test_delete_set_entity() throws {
        // Create effort entity, that will be used to create set entity.
        let effortEntity = try createEffortEntity(workoutData: .sample1, exerciseData: .sampleBenchPress, setsData: [])

        // Create set entity.
        let setEntity = try createSetEntity(in: effortEntity, setData: .sample1)

        // Delete set entity
        setEntity.delete()

        // Verify that set entity was deleted.
        try fetchRequestShouldReturnElements(0, for: SetEntity.self)

        // Verify that effort relatet to this set entity still exist.
        try fetchRequestShouldReturnElements(1, for: EffortEntity.self)

        // Verify that effort entity relatet to this set entity has no sets.
        XCTAssertEqual(effortEntity.numberOfSets, 0)
    }
}

// MARK: - Steps

extension SetEntityTests {

    private func verifySetEntityData(set: SetEntity, effort: EffortEntity, setData: WorkoutSet) throws {
        XCTAssertEqual(set.effort, effort)
        XCTAssertEqual(set.reps, setData.reps)
        XCTAssertEqual(set.weight, setData.weight)
    }
}

