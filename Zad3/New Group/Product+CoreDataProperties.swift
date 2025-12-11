//
//  Product+CoreDataProperties.swift
//  Zad3
//
//  Created by user279431 on 12/11/25.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var desc: String?
    @NSManaged public var category: Category?

}

extension Product : Identifiable {

}
