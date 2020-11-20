//
//  Reminders.swift
//  Horsely
//
//  Created by Saba Dawit on 9/24/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import MobileCoreServices

struct Item: Identifiable {
    let id = UUID()
    let title: String
}
struct SheetView: View {
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView {
            Text("Sheet View content")
            .navigationBarTitle(Text("Sheet View"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Text("Done").bold()
                })
        }
    }
}
struct Reminders: View {
    @State private var items: [Item] = []
    @State private var editMode = EditMode.inactive
    private static var count = 0
    @State var showingDetail = false
    @State var showSheetView = false
    var body: some View {
       
        NavigationView {
            
            List {
                ForEach(items) { item in
                    Button(action: {
                        self.showSheetView.toggle()
                    }) {
                        Mood(image: "horse", title: item.title, type: "Thu, Sept 10", price: "Symptoms")
                    }.sheet(isPresented: self.$showSheetView) {
                        SheetView(showSheetView: self.$showSheetView)
                    }
                   
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
                .onInsert(of: [String(kUTTypeURL)], perform: onInsert)
            }
            .navigationBarTitle("Reminders")
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
            
            
        }
    }
     
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    private func onInsert(at offset: Int, itemProvider: [NSItemProvider]) {
        for provider in itemProvider {
            if provider.canLoadObject(ofClass: URL.self) {
                _ = provider.loadObject(ofClass: URL.self) { url, error in
                    DispatchQueue.main.async {
                        url.map { self.items.insert(Item(title: $0.absoluteString), at: offset) }
                    }
                }
            }
        }
    }
    
    private func onAdd() {
        items.append(Item(title: "Item #\(Self.count)"))
        Self.count += 1
    }
}

struct Reminders_Previews: PreviewProvider {
    static var previews: some View {
        Reminders()
    }
}
