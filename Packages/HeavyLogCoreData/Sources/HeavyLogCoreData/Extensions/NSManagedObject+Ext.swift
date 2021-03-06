//
//  NSManagedObject+Ext.swift
//  HeavyLogCoreData
//
//  Created by Sebastian Staszczyk on 07/08/2021.
//

import CoreData

extension NSManagedObject {

    /// Returns a description of search criteria used to retrieve data from a persistent store.
    /// - Parameters:
    ///   - sortDescriptors: The sort descriptors of the fetch request.
    ///   - predicate: The predicate of the fetch request.
    /// - Returns: A description of search criteria as `NSFetchRequest`.
    public static func nsFetchRequest<T: NSManagedObject>(sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil) -> NSFetchRequest<T> {
        let name = String(describing: type(of: T.self)).replacingOccurrences(of: ".Type", with: "")
        let request = NSFetchRequest<T>(entityName: name)
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        return request
    }

    /// Initializes a managed object from an entity description and inserts it into the specified managed object context.
    /// -  Use this init to avoid "Multiple NSEntityDescriptions Claim NSManagedObject Subclass" warning in unit testing.
    convenience init(in context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

    /// Returns the managed object context with which the managed object is registered, if found.
    func getContext() -> NSManagedObjectContext? {
        guard let context = self.managedObjectContext else {
            assertionFailure("Context coulnd not be found in: \(self.description)")
            return nil
        }
        return context
    }

    /// Specifies an object that should be removed from its persistent store when changes are committed.
    func delete() {
        guard let context = getContext() else { return }
        context.delete(self)
    }
}
