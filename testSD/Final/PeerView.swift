//
//  PeerView2.swift
//  testSD
//
//  Created by Nikolay Khort on 02.02.2024.
//

import Foundation
import SwiftUI
import SwiftData

struct PeerView: View {
    @Bindable var peer: Peer
    @Environment(\.modelContext) var context
    @Query var note: [Note]
    
    var body: some View {
        VStack (alignment: .leading){
            Text("About:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)
            if peer.peerSummary.isEmpty { Text("\(FishText.shortText)") }
            else { Text(peer.peerSummary) }
            Divider()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                NavigationLink(destination: AddNote(peer: peer)) {
                    Label("Add note", systemImage: "plus.circle.fill") }
            }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            
            List {
                ForEach(peer.peerNotes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading) {
                            if note.noteName.isEmpty {Text("NoteID: \(note.noteID)")}
                            Text("\(note.noteName)")
                                .font(.headline)
                            Text(note.noteDate.formatted(date: .abbreviated, time: .shortened))
                                .italic()
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        //context.delete(note[index])
                        peer.peerNotes.remove(at: index)
                    }}
            }.listStyle(PlainListStyle())
            .listRowBackground(Color.clear)
            
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Peer.self, configurations: config)
        let example = Peer()
        return PeerView(peer: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

//Adds notes to subClass of Peer:
struct AddNote: View {
    @Bindable var peer: Peer
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var summary: String = ""
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Add name", text: $name)
                TextField("Add summary", text: $summary)
                TextField("Add text", text: $text)
            }
            .navigationTitle("New note")
            .toolbar {
                ToolbarItemGroup() {
                    Button("Save") {
                        if name.isEmpty {
                            name = "No note name"
                        }
                        let note = Note(noteName: name, noteSummary: summary, noteText: text, noteDate: .now)
                        //let peerNote = Peer(peerName: peer.peerName, peerSummary: peer.peerSummary, peerNotes: [])
                        //context.insert(note)
                        peer.peerNotes.append(note)
                        dismiss()
                    }
                }
            }
        }
    }
}


// to add reminders, files etc
