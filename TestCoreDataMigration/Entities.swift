//
//  Entities.swift
//  TestCoreDataMigration
//
//  Created by Yriy Devyataev on 10.01.2024.
//

import CoreData

internal final class DBCustomerDraft: NSManagedObject {

    internal final class var entityName: String {
        "CustomerDraft"
    }

    @nonobjc
    internal final class func makeFetchRequest() -> NSFetchRequest<DBCustomerDraft> {
        NSFetchRequest<DBCustomerDraft>(entityName: self.entityName)
    }

    @NSManaged internal var email: String?
    @NSManaged internal var id: Int32
    @NSManaged internal var editTextTask: DBEditTextTask?

    init(id: Int32, context: NSManagedObjectContext) {
        super.init(entity: DBCustomerDraft.entity(), insertInto: context)
        self.id = id
    }

    @objc
    override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}

internal final class DBEditTextTask: NSManagedObject {

    internal final class var entityName: String {
        "EditTextTask"
    }

    @nonobjc
    internal final class func makeFetchRequest() -> NSFetchRequest<DBEditTextTask> {
        NSFetchRequest<DBEditTextTask>(entityName: self.entityName)
    }

    @NSManaged internal var chatId: String?
    @NSManaged internal var id: Int32
    @NSManaged internal var customerDraft: Set<DBCustomerDraft>?
//    @NSManaged internal var customerDraft: DBCustomerDraft?

    init(id: Int32, context: NSManagedObjectContext) {
        super.init(entity: DBEditTextTask.entity(), insertInto: context)
        self.id = id
    }

    @objc
    override private init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

}
