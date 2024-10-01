//
//  PeerView.swift
//  testSD
//
//  Created by Nikolay Khort on 29.01.2024.
//

import Foundation
import SwiftUI
import SwiftData

struct PeerView_old: View {
    @Bindable var peer: Peer
    @Environment(\.modelContext) var modelContext
    //@Query private var items: [Item]
    //@Query var peer: [Peer]
    //@State private var path = [Peer]()
    //@Query var note: [Note]
    //@State private var path = [Note]()
    
    var body: some View {
        VStack {
            TextField("Name", text: $peer.peerName)
                .padding(.leading, 4)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $peer.peerSummary)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                if peer.peerSummary.isEmpty {Text("Summary").padding(.top, 8).padding(.leading, 4).foregroundColor(.gray.opacity(0.6))}
            }
            //.padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: 100)
            Divider()
            NoteView(peer: peer)
            //NoteView().modelContainer(for: Note.self)
        }
        .padding()
//        .background(Color(red: 242/255, green: 234/255, blue: 221/255))
    }
}


/*struct PeerView_Previews: PreviewProvider {
    static var previews: some View {
        PeerView()
    }
}
*/


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Peer.self, configurations: config)
        let example = Peer()
        return PeerView_old(peer: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

/*struct PeerView_Previews: PreviewProvider {
    static var previews: some View {
        PeerView().modelContainer(for: Peer.self)
    }
}
*/
