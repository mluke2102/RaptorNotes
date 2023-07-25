//
//  ContentView.swift
//  RaptorNotes
//
//  Created by Matt Luke on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: RaptorNotesDocument

    var body: some View {
        
            RecorderView(sentences: $document.sentences)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(RaptorNotesDocument()))
    }
}
