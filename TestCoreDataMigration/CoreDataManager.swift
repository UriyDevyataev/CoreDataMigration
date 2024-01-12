//
//  CoreDataManager.swift
//  TestCoreDataMigration
//
//  Created by Юрий Девятаев on 10.01.2024.
//

import Foundation
import CoreData

class CoreDataManager {

    lazy var persistentContainer: Container = {
        Container.init()
    }()

    // MARK: - Singleton

    static let shared = CoreDataManager()

    // MARK: - SetUp

    func setup(completion: @escaping () -> Void) {
        self.loadPersistentStore {
            completion()
        }
    }

    // MARK: - Loading

    private func loadPersistentStore(completion: @escaping () -> Void) {

        let needMigration = self.persistentContainer.needMigration()

        if !needMigration {
            print("need migration")
            self.persistentContainer.migrate()
        } else {
            print("not need migration")
        }

        self.persistentContainer.loadPersistentStores { description, error in
            guard let error else {
                completion()
                return
            }
            fatalError("was unable to load store \(error)")
        }
    }

    func clean() {
        self.persistentContainer.clean()
    }

    func addCustomer() {
        self.persistentContainer.performBackgroundTask { context in

            let task = DBEditTextTask(id: 345, context: context)
            task.chatId = "chat id 345"

            let customer = DBCustomerDraft(id: 123, context: context)
            customer.email = "email@mail.com"

            customer.editTextTask = task

            do {
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                fatalError("save error \(error)")
            }
        }
    }

//    func printDB() {
//        let context = self.persistentContainer.newBackgroundContext()
//
//        let tasks = context.performAndWait {
//            do {
//                let fetchRequest = DBEditTextTask.makeFetchRequest()
//                return try context.fetch(fetchRequest)
//            } catch {
//                fatalError("printDB error \(error)")
//            }
//        }
//
//        let customers = context.performAndWait {
//            do {
//                let fetchRequest = DBCustomerDraft.makeFetchRequest()
//                return try context.fetch(fetchRequest)
//            } catch {
//                fatalError("printDB error \(error)")
//            }
//        }
//
//        print("================Print=============")
//
//        tasks.forEach {
//            print("task \($0.id), chatId = \($0.chatId)")
////            let customerIds = $0.customerDraft?.map { customer in customer.id }
////            let customerIds = $0.customerDraft?.id
////            print("customerIds = \(customerIds)")
//            print("customerIds = \($0.customerDraft)")
//        }
//
//        print("================")
//
//        customers.forEach {
//            print("customer \($0.id), email = \($0.email), customer task = \($0.editTextTask?.id), customer task chatId = \($0.editTextTask?.chatId)")
//        }
//
//        print("================End=============")
//
//    }
    func printDB() {
        let context = self.persistentContainer.newBackgroundContext()

        let tasks = context.performAndWait {
            do {
                let fetchRequest = DBEditTextTask.makeFetchRequest()
                return try context.fetch(fetchRequest)
            } catch {
                fatalError("printDB error \(error)")
            }
        }

        let customers = context.performAndWait {
            do {
                let fetchRequest = DBCustomerDraft.makeFetchRequest()
                return try context.fetch(fetchRequest)
            } catch {
                fatalError("printDB error \(error)")
            }
        }

        print("================Print=============")

        tasks.forEach {
            print("task = \($0)")
        }

        print("================")

        customers.forEach {
            print("customer = \($0)")
        }

        print("================End=============")

    }
}



