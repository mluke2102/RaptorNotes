//
//  RaptorNotesDocument.swift
//  RaptorNotes
//
//  Created by Matt Luke on 9/12/22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    
    static let raptNotesDocument = UTType(exportedAs: "com.mluke.RaptorNotes.rapt")
}

struct RaptorNotesDocument: FileDocument, Codable {
    var sentences: [Sentence]

    init(text: String = "Hello, world!") {
        
        let sentenceOne = Sentence(text: "Qui ea irure et eiusmod ullamco ullamco dolore duis Lorem non occaecat. Ex incididunt elit fugiat excepteur voluptate voluptate. Fugiat consectetur ullamco laboris consequat. Aliquip pariatur irure in tempor non ipsum exercitation proident officia laborum est commodo elit.",
                                   timestamp: "1:14:57",
                                   slide: 3,
                                   isProminent: false)
        
        let sentenceTwo = Sentence(text: "Irure velit in nulla reprehenderit consequat nulla non voluptate pariatur tempor amet do do velit. Eu adipisicing aliquip velit dolor exercitation adipisicing mollit aliqua sunt incididunt deserunt. Aliqua dolor excepteur nostrud proident proident sit consequat excepteur consequat dolor exercitation et labore elit. Ex esse ipsum occaecat sunt dolor dolore. Laboris adipisicing officia officia aliquip. Aliquip reprehenderit non irure ut.",
                                   timestamp: "1:25:31",
                                   slide: 4,
                                   isProminent: true)
        
        let sentenceThree = Sentence(text: "Proident eu est do voluptate commodo elit eiusmod officia. Ex excepteur magna eu ullamco laborum anim. Culpa aliqua adipisicing qui aliqua laboris consectetur sunt. Consequat quis non dolor commodo elit consectetur deserunt dolore sit magna aliquip ad.",
                                   timestamp: "1:28:07",
                                   slide: 5,
                                   isProminent: false)
        
        self.sentences = [sentenceOne, sentenceTwo, sentenceThree]
    }

    static var readableContentTypes: [UTType] { [.raptNotesDocument] }

    init(configuration: ReadConfiguration) throws {
        let data = configuration.file.regularFileContents!
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self)
        return .init(regularFileWithContents: data)
    }
}
