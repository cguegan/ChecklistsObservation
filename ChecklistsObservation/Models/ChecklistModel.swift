//
//  ChecklistModel.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation
import Observation

@Observable
class ChecklistModel: Identifiable {
    var id: String
    var title: String
    var notes: String
    var lines: [ChecklineModel]
    
    init(title: String, notes: String, lines: [ChecklineModel] = []) {
        self.id = UUID().uuidString
        self.title = title
        self.notes = notes
        self.lines = lines
    }
    
}

extension ChecklistModel {
    
    // Return the number of currently checked checklines
    var itemChecked: Int {
        let checkedCount = lines.reduce(0) { $0 + $1.counting }
        return checkedCount
    }
    
    // Return the number of checkline
    var totalCheckinesNbr: Int {
        let linesCount = lines.reduce(0) { checklinesCount, line in
            if line.type == .checkline {
                return checklinesCount + 1
            } else {
                return checklinesCount
            }
        }
        return linesCount
    }
    
    // Return the completion state as a double value from 0.0 to 1.0
    var completionState: Double {
        if itemChecked > 0 {
            return Double(itemChecked) / Double(totalCheckinesNbr)
        } else {
            return 0.0
        }
    }
    
    
}


