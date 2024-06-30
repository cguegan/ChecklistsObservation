//
//  Departments+Samples.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import Foundation

extension DepartmentModel {
    
    static let samples: [DepartmentModel] = [
        DepartmentModel(title: "Emergency",
                        icon:"bolt.circle",
                        checklists: ChecklistModel.bridgeSamples),
        DepartmentModel(title: "Bridge",
                        icon:"binoculars",
                        checklists: ChecklistModel.bridgeSamples),
        DepartmentModel(title: "Machinery",
                        icon:"wrench.and.screwdrive",
                        checklists: ChecklistModel.bridgeSamples),
        DepartmentModel(title: "Deck",
                        icon: "lifepreserver",
                        checklists: ChecklistModel.bridgeSamples),
        DepartmentModel(title: "Interior",
                        icon:"bed.double",
                        checklists: ChecklistModel.bridgeSamples)
        ]
        
    
}
