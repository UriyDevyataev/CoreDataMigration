//
//  Model.swift
//  TestCoreDataMigration
//
//  Created by Юрий Девятаев on 10.01.2024.
//

import CoreData

//extension Container {
//
//    static let model: NSManagedObjectModel = {
//
//        typealias Entity = NSEntityDescription
//        typealias Attribute = NSAttributeDescription
//        typealias Relationship = NSRelationshipDescription
//
//        let customerDraft = Entity(class: DBCustomerDraft.self)
//        let editTextTask = Entity(class: DBEditTextTask.self)
//
//        customerDraft.properties = [
//            Attribute(name: "email", type: .stringAttributeType, isOptional: true),
//            Attribute(name: "id", type: .integer32AttributeType),
//            Relationship(name: "editTextTask", type: .oneToOne, deleteRule: .cascadeDeleteRule, destinationEntity: editTextTask, isOptional: true)
//        ]
//
//        editTextTask.properties = [
//            Attribute(name: "chatId", type: .stringAttributeType, isOptional: true),
//            Attribute(name: "id", type: .integer32AttributeType),
//            Relationship(name: "customerDraft", type: .oneToMany, destinationEntity: customerDraft, isOptional: true)
//        ]
//
//
//        let model = NSManagedObjectModel()
//        model.entities = [customerDraft, editTextTask]
//
//        // Make inverse relationships
//        model.entities.forEach { entity in
//            entity.properties.forEach { relationship in
//                guard let relationship = relationship as? NSRelationshipDescription else { return }
//                let destionationEntity = relationship.destinationEntity
//                if let inverseRelationship = destionationEntity?.relationships(forDestination: entity).first {
//                    relationship.inverseRelationship = inverseRelationship
//                }
//            }
//        }
//
//        return model
//    }()
//
//}
//
//extension Container {
//
//    static let newModel: NSManagedObjectModel = {
//
//        typealias Entity = NSEntityDescription
//        typealias Attribute = NSAttributeDescription
//        typealias Relationship = NSRelationshipDescription
//
//        let customerDraft = Entity(class: DBCustomerDraft.self)
//        let editTextTask = Entity(class: DBEditTextTask.self)
//
//        customerDraft.properties = [
//            Attribute(name: "email", type: .stringAttributeType, isOptional: true),
//            Attribute(name: "id", type: .integer32AttributeType),
//            Relationship(name: "editTextTask", type: .oneToOne, deleteRule: .cascadeDeleteRule, destinationEntity: editTextTask, isOptional: true)
//        ]
//
//        editTextTask.properties = [
//            Attribute(name: "chatId", type: .stringAttributeType, isOptional: true),
//            Attribute(name: "id", type: .integer32AttributeType),
//            Relationship(name: "customerDraft", type: .oneToOne, destinationEntity: customerDraft, isOptional: true)
//        ]
//
//
//        let model = NSManagedObjectModel()
//        model.entities = [customerDraft, editTextTask]
//
//        // Make inverse relationships
//        model.entities.forEach { entity in
//            entity.properties.forEach { relationship in
//                guard let relationship = relationship as? NSRelationshipDescription else { return }
//                let destionationEntity = relationship.destinationEntity
//                if let inverseRelationship = destionationEntity?.relationships(forDestination: entity).first {
//                    relationship.inverseRelationship = inverseRelationship
//                }
//            }
//        }
//
//        return model
//    }()
//
//}


extension Container {

    static let model: NSManagedObjectModel = {
        // Создание сущности DBCustomerDraft
        let customerDraftEntity = NSEntityDescription()
        customerDraftEntity.name = "CustomerDraft"
        customerDraftEntity.managedObjectClassName = NSStringFromClass(DBCustomerDraft.self)

        // Определение атрибутов сущности DBCustomerDraft
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer32AttributeType
        customerDraftEntity.properties.append(idAttribute)

        let emailAttribute = NSAttributeDescription()
        emailAttribute.name = "email"
        emailAttribute.attributeType = .stringAttributeType
        customerDraftEntity.properties.append(emailAttribute)

        // Создание сущности DBEditTextTask
        let editTextTaskEntity = NSEntityDescription()
        editTextTaskEntity.name = "EditTextTask"
        editTextTaskEntity.managedObjectClassName = NSStringFromClass(DBEditTextTask.self)

        // Определение атрибутов сущности DBEditTextTask
        let editTextTaskIdAttribute = NSAttributeDescription()
        editTextTaskIdAttribute.name = "id"
        editTextTaskIdAttribute.attributeType = .integer32AttributeType
        editTextTaskEntity.properties.append(editTextTaskIdAttribute)

        let chatIdAttribute = NSAttributeDescription()
        chatIdAttribute.name = "chatId"
        chatIdAttribute.attributeType = .stringAttributeType
        editTextTaskEntity.properties.append(chatIdAttribute)

        // relationships

        // Определение отношения сущности DBCustomerDraft
        let editTextTaskRelationship = NSRelationshipDescription()
        editTextTaskRelationship.name = "editTextTask"
        editTextTaskRelationship.destinationEntity = editTextTaskEntity
        editTextTaskRelationship.maxCount = 1
        editTextTaskRelationship.minCount = 0
        editTextTaskRelationship.deleteRule = .nullifyDeleteRule
        customerDraftEntity.properties.append(editTextTaskRelationship)

        // Определение отношения сущности DBEditTextTask
        let customerDraftRelationship = NSRelationshipDescription()
        customerDraftRelationship.name = "customerDraft"
        customerDraftRelationship.destinationEntity = customerDraftEntity
        customerDraftRelationship.maxCount = 0
        customerDraftRelationship.minCount = 0
        customerDraftRelationship.deleteRule = .nullifyDeleteRule
        editTextTaskEntity.properties.append(customerDraftRelationship)

        let model = NSManagedObjectModel()
        // Добавление сущностей в модель
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
        // Создание сущности DBCustomerDraft
        let customerDraftEntity = NSEntityDescription()
        customerDraftEntity.name = "CustomerDraft"
        customerDraftEntity.managedObjectClassName = NSStringFromClass(DBCustomerDraft.self)

        // Определение атрибутов сущности DBCustomerDraft
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer32AttributeType
        customerDraftEntity.properties.append(idAttribute)

        let emailAttribute = NSAttributeDescription()
        emailAttribute.name = "email"
        emailAttribute.attributeType = .stringAttributeType
        customerDraftEntity.properties.append(emailAttribute)

        // Создание сущности DBEditTextTask
        let editTextTaskEntity = NSEntityDescription()
        editTextTaskEntity.name = "EditTextTask"
        editTextTaskEntity.managedObjectClassName = NSStringFromClass(DBEditTextTask.self)

        // Определение атрибутов сущности DBEditTextTask
        let editTextTaskIdAttribute = NSAttributeDescription()
        editTextTaskIdAttribute.name = "id"
        editTextTaskIdAttribute.attributeType = .integer32AttributeType
        editTextTaskEntity.properties.append(editTextTaskIdAttribute)

        let chatIdAttribute = NSAttributeDescription()
        chatIdAttribute.name = "chatId"
        chatIdAttribute.attributeType = .stringAttributeType
        editTextTaskEntity.properties.append(chatIdAttribute)

        // relationships

        // Определение отношения сущности DBCustomerDraft
        let editTextTaskRelationship = NSRelationshipDescription()
        editTextTaskRelationship.name = "editTextTask"
        editTextTaskRelationship.destinationEntity = editTextTaskEntity
        editTextTaskRelationship.maxCount = 1
        editTextTaskRelationship.minCount = 0
        editTextTaskRelationship.deleteRule = .nullifyDeleteRule
        customerDraftEntity.properties.append(editTextTaskRelationship)

        // Определение отношения сущности DBEditTextTask
        let customerDraftRelationship = NSRelationshipDescription()
        customerDraftRelationship.name = "customerDraft"
        customerDraftRelationship.destinationEntity = customerDraftEntity
        customerDraftRelationship.maxCount = 0
        customerDraftRelationship.minCount = 0
        customerDraftRelationship.deleteRule = .nullifyDeleteRule
        editTextTaskEntity.properties.append(customerDraftRelationship)

        let model = NSManagedObjectModel()
        // Добавление сущностей в модель
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
