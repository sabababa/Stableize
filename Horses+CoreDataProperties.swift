//
//  Horses+CoreDataProperties.swift
//  
//
//  Created by Saba Dawit on 10/25/20.
//
//

import Foundation
import CoreData


extension Horses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Horses> {
        return NSFetchRequest<Horses>(entityName: "Horses")
    }

    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var vetName: String?
    @NSManaged public var vetNumber: String?

}
