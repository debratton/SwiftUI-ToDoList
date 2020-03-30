//
//  NSmoc.swift
//  ToDoList
//
//  Created by David E Bratton on 3/29/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let appDelgate = UIApplication.shared.delegate as! AppDelegate
        return appDelgate.persistentContainer.viewContext
    }
}
