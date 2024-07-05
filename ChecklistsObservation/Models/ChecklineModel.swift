//
//  ChecklineModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import SwiftData

@Model
class ChecklineModel: Identifiable, Codable {
    var id: String
    var title: String
    var order: Int = 0
    var action: String
    var notes: String
    var isChecked: Bool
    var type: ChecklineType
    
    init(title: String, order: Int, action: String, notes: String = "") {
        self.id = UUID().uuidString
        self.title = title
        self.order = order
        self.action = action
        self.notes = notes
        self.isChecked = false
        self.type = .checkline
    }
    
    init(title: String, order: Int, type: ChecklineType) {
        self.id = UUID().uuidString
        self.title = title
        self.order = order
        self.action = ""
        self.notes = ""
        self.isChecked = false
        self.type = type
    }
    
    init(title: String, order: Int, notes: String) {
        self.id = UUID().uuidString
        self.title = title
        self.order = order
        self.action = ""
        self.notes = notes
        self.isChecked = false
        self.type = ChecklineType.comment
    }
    
    // Make checklines model codable
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _title = "title"
        case _order = "order"
        case _action = "action"
        case _notes = "notes"
        case _isChecked = "isChecked"
        case _type = "type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: ._id)
        title = try container.decode(String.self, forKey: ._title)
        order = try container.decode(Int.self, forKey: ._order)
        action = try container.decode(String.self, forKey: ._action)
        notes = try container.decode(String.self, forKey: ._notes)
        isChecked = try container.decode(Bool.self, forKey: ._isChecked)
        type = try container.decode(ChecklineType.self, forKey: ._type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(title, forKey: ._title)
        try container.encode(order, forKey: ._order)
        try container.encode(action, forKey: ._action)
        try container.encode(notes, forKey: ._notes)
        try container.encode(isChecked, forKey: ._isChecked)
        try container.encode(type, forKey: ._type)
    }
    
}


// MARK: - Computed properties
// ———————————————————————————

extension ChecklineModel {
    
    var counting: Int {
        isChecked ? 1 : 0
    }
    
}


// MARK: - Checkline Enum
// ——————————————————————

enum ChecklineType: Codable, CaseIterable, Identifiable {
    case sectionTitle
    case checkline
    case comment
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .sectionTitle:
            return "Section Title"
        case .checkline:
            return "Checkline"
        case .comment:
            return "Comment"
        }
    }
}
