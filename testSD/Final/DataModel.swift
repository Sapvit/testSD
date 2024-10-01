//
//  Note.swift
//  testSD
//
//  Created by Nikolay Khort on 19.01.2024.
//

//Start with this - data will look as described.
//Then - to create a peer creation window, and inside this peer one will create notes linked to this peer.

import Foundation
import SwiftData

@Model
class Peer {
    let peerID = UUID()
    var peerName: String
    var peerSummary: String
    var peerNotes: [Note]
    
    init(peerName: String = "", peerSummary: String = "", peerNotes: [Note] = []) {
        self.peerName = peerName
        self.peerSummary = peerSummary
        self.peerNotes = peerNotes
    }
}

@Model
class Note {
    let noteID = UUID()
    var noteName: String
    var noteSummary: String
    var noteText: String
    var noteDate: Date
    
    init(noteName: String = "", noteSummary: String = "", noteText: String = "", noteDate: Date = .now) {
        //self.noteID = noteID
        self.noteName = noteName
        self.noteSummary = noteSummary
        self.noteText = noteText
        self.noteDate = noteDate
    }
}


struct FishText {
    static let shortText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    static let longText = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
}
