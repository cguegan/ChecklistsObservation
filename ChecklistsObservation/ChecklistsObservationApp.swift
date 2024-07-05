//
//  ChecklistsObservationApp.swift
//  ChecklistsObservation
//
//  Created by Christophe Guégan on 30/06/2024.
//

import SwiftUI
import SwiftData

@main
struct ChecklistsObservationApp: App {
    
    // print out the location of the sql database
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(appContainer)
        }
        
       
    }
}

