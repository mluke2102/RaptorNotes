//
//  Sentence.swift
//  RaptorNotes
//
//  Created by Matt Luke on 9/12/22.
//

import Foundation

public struct Sentence : Hashable, Codable {
    //public var id: String
    
    var text: String
    var timestamp: String
    var slide: Int
    var isProminent: Bool
}
