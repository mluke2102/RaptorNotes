//
//  RaptorNotesApp.swift
//  RaptorNotes
//
//  Created by Matt Luke on 9/12/22.
//

import SwiftUI

@main
struct RaptorNotesApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: RaptorNotesDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
