//
//  PeersListView.swift
//  testSD
//
//  Created by Nikolay Khort on 31.01.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) var context
    let container: ModelContainer = {
        let schema = Schema([Peer.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    @Query() var peers: [Peer]
    @State private var peerToEdit: Peer?
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(peers) {peer in
                    NavigationLink {
                        //PeerView(peer: peer)
                        PeerView(peer: peer)
                            .toolbar { NavigationLink(destination: EditPeer(peer: peer)) {
                                Label("Edit peer", systemImage: "square.and.pencil") } }
                            .navigationTitle(peer.peerName)
                    } label: {
                        Text(peer.peerName)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(peers[index])
//Need to add state to retern Home or to next item after delete (now it stays with earlier selected item)
                    }
                }
            }
            .navigationTitle("Peers")
            .toolbar {
/*
 #if os(iOS)
                if peers.isEmpty == false {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
#endif */
//to add HomeButton maybe here
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: HomeView().navigationTitle("Today")) {
                        Label("Home", systemImage: "house")
                    }
                }
                ToolbarItem {
                    NavigationLink(destination: AddPeer()) {
                        Label("Add peer", systemImage: "plus")
                    }
                }
            }
            .overlay {
                if peers.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No peers", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Add one")
                    }, actions: {})
                }
            }
        } detail: {
            if peers.isEmpty {
                NavigationLink(destination: AddPeer()) {
                    Label("Add peer", systemImage: "plus") }
            } else {
                Text("Select an item")
                //To add today view maybe (and add Home button to the main menu to be able to navigaate there any time)
            }
        }
    }
}

#Preview {
    MainView().modelContainer(for: Peer.self)
}

/*struct PeerCell: View {
    let peer: Peer
    
    var body: some View {
        HStack {
            Text(peer.peerName)
            Text("\(peer.peerID)")
            Text(peer.peerSummary)
        }
    }
}*/


struct AddPeer: View {
    //@Bindable var peer: Peer
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var summary: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Peer name", text: $name)
                TextField("Peer summary", text: $summary)
            }
            .navigationTitle("New peer")
            .toolbar {
                ToolbarItemGroup() {
                    Button("Save") {
                        if name.isEmpty {
                            name = "No Name"
                        }
                        let peer = Peer(peerName: name, peerSummary: summary, peerNotes: [])
                        context.insert(peer)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct EditPeer: View {
    @Bindable var peer: Peer
    //@Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    //@State private var name: String = ""
    //@State private var summary: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Peer name", text: $peer.peerName)
                TextField("Peer summary", text: $peer.peerSummary)
            }
            .navigationTitle("Edit peer")
            .toolbar {
                ToolbarItemGroup() {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("home view")
    }
}
