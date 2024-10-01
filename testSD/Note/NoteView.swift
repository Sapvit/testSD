//
//  NoteView.swift
//  testSD
//
//  Created by Nikolay Khort on 19.01.2024.
//

import SwiftUI
import SwiftData

struct NoteView: View {
    @Bindable var peer: Peer
    @Environment(\.modelContext) var modelContext
    @Query var note: [Note]
    @State private var path = [Note]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                //Button("Add note", systemImage: "plus", action: addNote)
                HStack {
                    Button(action: addNote) {
                        //Label("New Note", systemImage: "plus")
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                //Text("New note")
                            Label("New Note", systemImage: "plus.circle.fill")
                        }
                    }.frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                }

                List {
                    ForEach(note) { note in
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
                    .onDelete(perform: deleteNote)
                    .listRowBackground(Color.clear)
                    
                }.navigationTitle("")
                .navigationDestination(for: Note.self, destination: NoteEditView.init)
                //.navigationBarHidden(true)
                .listStyle(PlainListStyle())
                
                .background(Color.clear)
                /*.toolbar {
                    //Button("Add note samples", action: addNoteSamples)
                    Button("Add note", systemImage: "plus", action: addNote)
                }*/
                //Divider()
                //Spacer(minLength: 100)
            }//.background(Color(red: 242/255, green: 234/255, blue: 221/255))
        }
    }
    
    /*
    func addNoteSamples() {
        let note1 = Note(noteSummary: "note1")
        let note2 = Note(noteText: "note2")
        let note3 = Note(noteText: "note3")
        
        
        modelContext.insert(note1)
        modelContext.insert(note2)
        modelContext.insert(note3)
    }
    */
    
    func addNote() {
        let note = Note()
        modelContext.insert(note)
        path = [note]
    }
    
    func deleteNote(_ indexSet: IndexSet) {
        for index in indexSet {
            let note=note[index]
            modelContext.delete(note)
        }
    }
}

/*struct MeetingNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView().modelContainer(for: Note.self)
    }
}*/

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Peer.self, configurations: config)
        let example = Peer()
        return NoteView(peer: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}


/*
#Preview {
    NoteView().modelContainer(for: Note.self)
}
*/
