//
//  EffortEntity+CoreDataClass.swift
//  HeavyLog
//
//  Created by Sebastian Staszczyk on 14/08/2021.
//
//

import CoreData
import Foundation

@objc(EffortEntity) public class EffortEntity: NSManagedObject {

    @NSManaged private(set) var exerciseId: Int
    @NSManaged private(set) var exercise: ExerciseEntity
    @NSManaged private(set) var workout: WorkoutEntity
    @NSManaged private var sets: Set<SetEntity>

    var numberOfSets: Int {
        sets.count
    }
}

// MARK: - Methods

extension EffortEntity {

    @discardableResult static func create(in workout: WorkoutEntity, effortData: Effort) -> EffortEntity? {
        guard let context = workout.getContext() else { return nil }
        let effort = EffortEntity(in: context)
        effort.workout = workout
        effort.modify(effort: effortData)
        return effort
    }

    @discardableResult func modify(effort: Effort) -> EffortEntity {
        exercise = effort.exercise
        exerciseId = effort.exerciseId
        deleteAllSets()
        addSets(effort.sets)
        return self
    }

    // MARK: - Helpers

    private func addSets(_ sets: [WorkoutSet]) {
        for set in sets { addSet(set) }
    }

    private func deleteAllSets() {
        for set in sets {
            removeFromSets(set)
            set.delete()
        }
    }

    private func addSet(_ workoutSet: WorkoutSet) {
        SetEntity.create(in: self, workoutSet: workoutSet)
    }
}

extension EffortEntity {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: SetEntity)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: SetEntity)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)
}

extension EffortEntity: Identifiable {}
