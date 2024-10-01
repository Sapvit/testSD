//
//  NoteEditView.swift
//  testSD
//
//  Created by Nikolay Khort on 19.01.2024.
//

import SwiftUI
import SwiftData

struct NoteEditView: View {
    @Bindable var note: Note
    
    var body: some View {
        VStack {
            HStack {
                TextField("Name", text: $note.noteName)
                Divider()
                DatePicker("Date", selection: $note.noteDate)
                    .frame(maxWidth: 300)
            }.frame(maxHeight: 50)
            .padding()
            
            Divider()
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $note.noteSummary)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                if note.noteSummary.isEmpty {Text("Summary").padding(.top, 7).foregroundColor(.gray.opacity(0.6))}
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: 100)
            
            Divider()
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $note.noteText)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                if note.noteText.isEmpty {Text("Note").padding(.top, 7).foregroundColor(.gray.opacity(0.6))}
            }.frame(maxWidth: .infinity, minHeight: 400)
            .padding(.horizontal)
            
        }.navigationTitle("")
        //.navigationTitle("Edit note")
//            .background(Color(red: 242/255, green: 234/255, blue: 221/255))
            
        
        //Old simple form:
        /*Form {
            HStack {
                TextField("Name", text: $note.noteName)
                Divider()
                Spacer()
                DatePicker("Date", selection: $note.noteDate)
            }.padding()
            TextField("Summary", text: $note.noteSummary)
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding(.horizontal)
            TextField("Text", text: $note.noteText)
                .frame(maxWidth: .infinity, minHeight: 400)
                .padding(.horizontal)
        }
        .navigationTitle("Edit note")*/
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Note.self, configurations: config)
        let example = Note()
        return NoteEditView(note: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
