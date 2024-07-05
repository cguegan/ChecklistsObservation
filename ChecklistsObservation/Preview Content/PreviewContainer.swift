//
//  PreviewContainer.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 04/07/2024.
//

import Foundation
import SwiftData

@MainActor
var previewContainer: ModelContainer = {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DepartmentModel.self, configurations: config)
    
    for department in DepartmentModel.samples {
        container.mainContext.insert(department)
    }
    
    return container
    
}()
