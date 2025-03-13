//
//  SwiftUIMemoApp.swift
//  SwiftUIMemo
//
//  Created by 강윤서 on 3/11/25.
//

import SwiftUI

@main
struct SwiftUIMemoApp: App {
    @StateObject var store =  MemoStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
