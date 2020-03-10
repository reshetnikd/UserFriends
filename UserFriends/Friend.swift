//
//  Friend.swift
//  UserFriends
//
//  Created by Dmitry Reshetnik on 10.03.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import Foundation
import CoreData

@objc(Friend)
class Friend: NSManagedObject, Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }
    
    @NSManaged var id: String?
    @NSManaged var name: String?
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext) else {
            fatalError("Failed to decode Friend")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

}
