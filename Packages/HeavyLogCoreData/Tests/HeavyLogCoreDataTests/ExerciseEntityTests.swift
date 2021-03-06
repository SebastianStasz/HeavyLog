//
//  ExerciseEntityTests.swift
//  HeavyLogCoreDataTests
//
//  Created by Sebastian Staszczyk on 07/08/2021.
//

import Combine
import CoreData
import XCTest
@testable import HeavyLogCoreData

class ExerciseEntityTests: XCTestCase, CoreDataSteps {

    private var cancellable: AnyCancellable?
    var context = PersistenceController.previewEmpty.context

    override func setUpWithError() throws {
        context.reset()
        cancellable = nil
        context = PersistenceController.previewEmpty.context
    }

    // MARK: - Tests

    func test_create_exercise_entity() throws {
        // Define exercise data.
        let exerciseData = ExerciseData.sampleBenchPress

        // Before creating, there should not be any exercises.
        try fetchRequestShouldReturnElements(0, for: ExerciseEntity.self)

        // Create exercise entity using defined data.
        let exerciseEntity = try createExerciseEntity(exerciseData: exerciseData)

        // After creating, there should be one exercise.
        try fetchRequestShouldReturnElements(1, for: ExerciseEntity.self)

        // Verify that exercise entity data is correct.
        try verifyExerciseEntityData(exerciseEntity, exerciseData: exerciseData)

        // Save context.
        try saveContext()
    }

    func test_edit_exercise_entity() throws {
        // Define initial exercise data.
        let exerciseData = ExerciseData.sampleBenchPress

        // Create exercise entity using defined data.
        let exerciseEntity = try createExerciseEntity(exerciseData: exerciseData)

        // Modify exercise entity using classic deadlift data.
        exerciseEntity.modify(exerciseData: .sampleClassicDeadlift)

        // Verify that data has been changed, but ID is the same.
        try verifyExerciseEntityData(exerciseEntity, exerciseData: .sampleClassicDeadlift, id: exerciseData.id)

        // Save context.
        try saveContext()
    }

    func test_delete_exercise_entity() throws {
        // Define exercise data.
        let exerciseData = ExerciseData.sampleClassicDeadlift

        // Create exercise entity.
        let exerciseEntity = try createExerciseEntity(exerciseData: exerciseData)

        // Create effort entity.
        let effortEntity = try createEffortEntity(workoutData: .sample1, exerciseEntity: exerciseEntity, setsData: [])

        // Create workout template entity that will use created exercise.
        let workoutTemplateEntity = createWorkoutTemplateEntity(using: .init(name: "A", exercises: [exerciseEntity]))

        // Delete exercise entity.
        exerciseEntity.delete()

        // Verify that exercise entity was deleted.
        try fetchRequestShouldReturnElements(0, for: ExerciseEntity.self)

        // Verify that workout template entity still exist.
        try fetchRequestShouldReturnElements(1, for: WorkoutTemplateEntity.self)

        // Verify that workout template entity has no exercises.
        XCTAssertEqual(workoutTemplateEntity.exercises.count, 0)

        // Verify that effort entity still exist.
        try fetchRequestShouldReturnElements(1, for: EffortEntity.self)

        // Verify effort properties after deleting an exercise.
        try verifyEffortPropertiesAfterExerciseDeleted(effort: effortEntity, id: exerciseData.id)

        // Save context.
        try saveContext()
    }

    func test_load_exercises_data() throws {
        // Before loading there should not be exercises.
        try fetchRequestShouldReturnElements(0, for: ExerciseEntity.self)

        // Load exercise data.
        loadExerciseData()

        // After loading there should be three exercises.
        try fetchRequestShouldReturnElements(10, for: ExerciseEntity.self)

        // Save context.
        try saveContext()
    }
}

// MARK: - Steps

extension ExerciseEntityTests {

    private func loadExerciseData() {
        cancellable = ExerciseEntity.loadStaticData(to: context)
        sleep(1)
    }

    private func verifyExerciseEntityData(_ exercise: ExerciseEntity, exerciseData data: ExerciseData, id: Int? = nil) throws {
        XCTAssertEqual(exercise.type, data.type)
        XCTAssertEqual(exercise.nameKey, data.nameKey)
        XCTAssertEqual(exercise.name, data.name)
        XCTAssertEqual(exercise.shortName, data.shortName)
        XCTAssertEqual(exercise.difficulty, data.difficulty)
        XCTAssertEqual(exercise.section, data.section)
        XCTAssertEqual(exercise.information, data.information)
        XCTAssertEqual(exercise.mainBodyPart, data.mainBodyPart)
        XCTAssertEqual(exercise.additionalBodyParts, data.additionalBodyParts)
        XCTAssertEqual(exercise.numberOfEfforts, 0)
        XCTAssertEqual(exercise.isEditable, true)
        XCTAssertEqual(exercise.id_, id ?? data.id)
    }

    private func verifyEffortPropertiesAfterExerciseDeleted(effort: EffortEntity, id: Int) throws {
        // Related exercise in effort entity should be nil.
        XCTAssertEqual(effort.exercise, nil)
        // Related exercise id in effort entity should contain previous exercise id.
        XCTAssertEqual(effort.exerciseId, id)
    }
}
