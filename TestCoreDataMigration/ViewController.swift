//
//  ViewController.swift
//  TestCoreDataMigration
//
//  Created by Yriy Devyataev on 10.01.2024.
//

import UIKit

class ViewController: UIViewController {

    private let manager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func cleanAction(_ sender: Any) {
        manager.clean()
    }
    @IBAction func addAction(_ sender: Any) {
        manager.addCustomer()
    }
    @IBAction func printAction(_ sender: Any) {
        manager.printDB()
    }
    
}

