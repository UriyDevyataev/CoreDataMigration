//
//  Model.swift
//  TestCoreDataMigration
//
//  Created by Yriy Devyataev on 10.01.2024.
//

import CoreData

extension Container {

    static let model: NSManagedObjectModel = {
        // Create DBCustomerDraft
        let customerDraftEntity = NSEntityDescription()
        customerDraftEntity.name = "CustomerDraft"
        customerDraftEntity.managedObjectClassName = NSStringFromClass(DBCustomerDraft.self)

        // Attributes DBCustomerDraft
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer32AttributeType
        customerDraftEntity.properties.append(idAttribute)

        let emailAttribute = NSAttributeDescription()
        emailAttribute.name = "email"
        emailAttribute.attributeType = .stringAttributeType
        customerDraftEntity.properties.append(emailAttribute)

        // Create DBEditTextTask
        let editTextTaskEntity = NSEntityDescription()
        editTextTaskEntity.name = "EditTextTask"
        editTextTaskEntity.managedObjectClassName = NSStringFromClass(DBEditTextTask.self)

        // Attributes DBEditTextTask
        let editTextTaskIdAttribute = NSAttributeDescription()
        editTextTaskIdAttribute.name = "id"
        editTextTaskIdAttribute.attributeType = .integer32AttributeType
        editTextTaskEntity.properties.append(editTextTaskIdAttribute)

        let chatIdAttribute = NSAttributeDescription()
        chatIdAttribute.name = "chatId"
        chatIdAttribute.attributeType = .stringAttributeType
        editTextTaskEntity.properties.append(chatIdAttribute)

        // relationships

        let editTextTaskRelationship = NSRelationshipDescription()
        editTextTaskRelationship.name = "editTextTask"
        editTextTaskRelationship.destinationEntity = editTextTaskEntity
        editTextTaskRelationship.maxCount = 1
        editTextTaskRelationship.minCount = 0
        editTextTaskRelationship.deleteRule = .nullifyDeleteRule
        customerDraftEntity.properties.append(editTextTaskRelationship)

        let customerDraftRelationship = NSRelationshipDescription()
        customerDraftRelationship.name = "customerDraft"
        customerDraftRelationship.destinationEntity = customerDraftEntity
        customerDraftRelationship.maxCount = 0
        customerDraftRelationship.minCount = 0
        customerDraftRelationship.deleteRule = .nullifyDeleteRule
        editTextTaskEntity.properties.append(customerDraftRelationship)

        let model = NSManagedObjectModel()
        model.entities = [customerDraftEntity, editTextTaskEntity]

        // Make inverse relationships
        model.entities.forEach { entity in
            entity.properties.forEach { relationship in
                guard let relationship = relationship as? NSRelationshipDescription else { return }
                let destionationEntity = relationship.destinationEntity
                if let inverseRelationship = destionationEntity?.relationships(forDestination: entity).first {
                    relationship.inverseRelationship = inverseRelationship
                }
            }
        }

        return model
    }()
}

extension Container {

    static let newModel: NSManagedObjectModel = {
        // Create DBCustomerDraft
        let customerDraftEntity = NSEntityDescription()
        customerDraftEntity.name = "CustomerDraft"
        customerDraftEntity.managedObjectClassName = NSStringFromClass(DBCustomerDraft.self)

        // Attributes DBCustomerDraft
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer32AttributeType
        customerDraftEntity.properties.append(idAttribute)

        let emailAttribute = NSAttributeDescription()
        emailAttribute.name = "email"
        emailAttribute.attributeType = .stringAttributeType
        customerDraftEntity.properties.append(emailAttribute)

        // Create DBEditTextTask
        let editTextTaskEntity = NSEntityDescription()
        editTextTaskEntity.name = "EditTextTask"
        editTextTaskEntity.managedObjectClassName = NSStringFromClass(DBEditTextTask.self)

        // Attributes DBEditTextTask
        let editTextTaskIdAttribute = NSAttributeDescription()
        editTextTaskIdAttribute.name = "id"
        editTextTaskIdAttribute.attributeType = .integer32AttributeType
        editTextTaskEntity.properties.append(editTextTaskIdAttribute)

        let chatIdAttribute = NSAttributeDescription()
        chatIdAttribute.name = "chatId"
        chatIdAttribute.attributeType = .stringAttributeType
        editTextTaskEntity.properties.append(chatIdAttribute)

        // relationships

        let editTextTaskRelationship = NSRelationshipDescription()
        editTextTaskRelationship.name = "editTextTask"
        editTextTaskRelationship.destinationEntity = editTextTaskEntity
        editTextTaskRelationship.maxCount = 1
        editTextTaskRelationship.minCount = 0
        editTextTaskRelationship.deleteRule = .nullifyDeleteRule
        customerDraftEntity.properties.append(editTextTaskRelationship)

        let customerDraftRelationship = NSRelationshipDescription()
        customerDraftRelationship.name = "customerDraft"
        customerDraftRelationship.destinationEntity = customerDraftEntity
        customerDraftRelationship.maxCount = 1
        customerDraftRelationship.minCount = 0
        customerDraftRelationship.deleteRule = .nullifyDeleteRule
        editTextTaskEntity.properties.append(customerDraftRelationship)

        let model = NSManagedObjectModel()
        model.entities = [customerDraftEntity, editTextTaskEntity]

        // Make inverse relationships
        model.entities.forEach { entity in
            entity.properties.forEach { relationship in
                guard let relationship = relationship as? NSRelationshipDescription else { return }
                let destionationEntity = relationship.destinationEntity
                if let inverseRelationship = destionationEntity?.relationships(forDestination: entity).first {
                    relationship.inverseRelationship = inverseRelationship
                }
            }
        }

        return model
    }()
}
