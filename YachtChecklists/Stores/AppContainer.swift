//
//  AppContainer.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 04/07/2024.
//

import Foundation
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        
        let container = try ModelContainer(for: DepartmentModel.self)
        
        // Make sure the persistent store is empty. If it's not, return the non-empty container.
        
        var itemFetchDescriptor = FetchDescriptor<DepartmentModel>()
        itemFetchDescriptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }
        
        // This code will only run if the persistent store is empty.
        
        for department in DepartmentModel.samples {
            container.mainContext.insert(department)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
