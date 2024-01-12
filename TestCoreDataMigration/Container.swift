//
//  Container.swift
//  TestCoreDataMigration
//
//  Created by Yriy Devyataev on 10.01.2024.
//

import CoreData
import Foundation

final class Container: NSPersistentContainer {

    private static let dbFileName = "myDB"

    init() {
        super.init(name: Self.dbFileName, managedObjectModel: Self.model)
//        super.init(name: Self.dbFileName, managedObjectModel: Self.newModel)
    }

    internal func clean() {
        let entityNames = [DBCustomerDraft.entityName]
        self.performBackgroundTask { context in
            do {
                for entityName in entityNames {
                    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                    try context.execute(deleteRequest)
                }
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func needMigration() -> Bool {
        guard let storeURL = self.persistentStoreDescriptions.first?.url else {
//            fatalError("persistentContainer was not set up properly")
            return false
        }

        guard let metadata = try? NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: storeURL, options: nil) else {
//            fatalError("persistentContainer was not set up properly")
            return false
        }

        let isCompatible = Self.newModel.isConfiguration(withName: nil, compatibleWithStoreMetadata: metadata)

        return !isCompatible
    }

}

extension Container {

    func migrate() {

        let newStoreURL = Self.defaultDirectoryURL()
            .appendingPathComponent("\(Self.dbFileName)New", isDirectory: false)
            .appendingPathExtension("sqlite")

        let storeURL = Self.defaultDirectoryURL()
            .appendingPathComponent(Self.dbFileName, isDirectory: false)
            .appendingPathExtension("sqlite")

        let migrationManager = NSMigrationManager(
            sourceModel: Self.model,
            destinationModel: Self.newModel
        )

        do {
            try migrationManager.migrateStore(
                from: storeURL,
                sourceType: NSSQLiteStoreType,
                options: nil,
                with: self.createMappingModel(),
                toDestinationURL: newStoreURL,
                destinationType: NSSQLiteStoreType,
                destinationOptions: nil
            )
        } catch {
            fatalError(error.localizedDescription)
        }

        // destroy old

        do {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel())
            try persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        } catch let error {
            fatalError("failed to destroy persistent store at \(storeURL), error: \(error)")
        }

        // replace

        do {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel())
            try persistentStoreCoordinator.replacePersistentStore(at: storeURL, destinationOptions: nil, withPersistentStoreFrom: newStoreURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
        } catch let error {
            fatalError("failed to replace persistent store at \(newStoreURL) with \(storeURL), error: \(error)")
        }

        // destroy new

        do {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: NSManagedObjectModel())
            try persistentStoreCoordinator.destroyPersistentStore(at: newStoreURL, ofType: NSSQLiteStoreType, options: nil)
        } catch let error {
            fatalError("failed to destroy persistent store at \(storeURL), error: \(error)")
        }
    }

    func createMappingModel() -> NSMappingModel {
        let editableMessageMapping = NSEntityMapping()
        editableMessageMapping.name = "MappingEditTextTask"
        editableMessageMapping.sourceEntityName = "EditTextTask"
        editableMessageMapping.destinationEntityName = "EditTextTask"
        editableMessageMapping.mappingType = .copyEntityMappingType
        editableMessageMapping.entityMigrationPolicyClassName = "TestCoreDataMigration.TaskMigrationPolicy"

        let idPropertyMapping = NSPropertyMapping()
        idPropertyMapping.name = "id"
        idPropertyMapping.valueExpression = NSExpression(format: "$source.id")

        let chatIdPropertyMapping = NSPropertyMapping()
        chatIdPropertyMapping.name = "chatId"
        chatIdPropertyMapping.valueExpression = NSExpression(format: "$source.chatId")

        let relationshipMapping = NSPropertyMapping()
        // add code for mapping

        editableMessageMapping.attributeMappings = [idPropertyMapping, chatIdPropertyMapping]
        editableMessageMapping.relationshipMappings = [relationshipMapping]

        let mappingModel = NSMappingModel()
        mappingModel.entityMappings = [editableMessageMapping]
        return mappingModel
    }
}

final class TaskMigrationPolicy: NSEntityMigrationPolicy {

    override func begin(_ mapping: NSEntityMapping, with manager: NSMigrationManager) throws {
        print("begin")
    }

    override func createDestinationInstances(
        forSource sourceInstance: NSManagedObject,
        in mapping: NSEntityMapping,
        manager: NSMigrationManager
    ) throws {
        print("begin")
    }

    override func endInstanceCreation(forMapping mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        print("endInstanceCreation")
    }

    override func createRelationships(forDestination dInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        print("createRelationships")
    }

    override func endRelationshipCreation(forMapping mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        print("endRelationshipCreation")
    }

    override func performCustomValidation(forMapping mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        print("performCustomValidation")
    }

    override func end(_ mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        print("end")
    }
}
