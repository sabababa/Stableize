//
//  Daily+CoreDataProperties.swift
//  
//
//  Created by Saba Dawit on 9/30/20.
//
//

import Foundation
import CoreData


var wrappedMood: String {
    mood ?? "Unkown"
}
extension Daily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Daily> {
        return NSFetchRequest<Daily>(entityName: "Daily")
    }

    @NSManaged public var mood: String?
    @NSManaged public var medsTaken: Bool
    @NSManaged public var symptoms: String?
    @NSManaged public var whichMeds: String?
    @NSManaged public var triggers: String?
    @NSManaged public var triggers: Date?
    

}

