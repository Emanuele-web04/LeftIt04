//
//  ObjectsView.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 26/03/24.
//

import SwiftUI
import SwiftData

struct ObjectsView: View {
    
    @Query var objects: [ObjectItem]
    @Bindable var location: LocationItem
    @Environment(\.modelContext) var modelContext
    
    @State private var showObjectSheet = false

    @ViewBuilder
    var objectToBring: some View {
        let countObjects = filteredObjects.count
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .frame(maxWidth: .infinity)
                .frame(height: 110)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.primaryOrange, .secondaryOrange]), startPoint: .top, endPoint: .bottom))
            HStack {
                VStack(alignment: .leading) {
                    Text("Before leaving:").foregroundStyle(.white).opacity(0.8).font(.caption)
                    Text("\(countObjects)" + (countObjects > 1 ? " objects" : " object")).foregroundStyle(.white).font(.title).fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "door.right.hand.open").foregroundStyle(.white).font(.largeTitle)
            }
            .padding(.horizontal, 30)
        }.cornerRadius(10)
    }
    
    var filteredObjects: [ObjectItem] {
        let filtered = objects.filter { $0.id == location.name }
        print("Filtering for location: \(location.name), found \(filtered.count) matching objects.")
        return filtered
    }

    
    var body: some View {
        //devo filtrare in base all'uguaglianza con il titolo della view
        let objectsSorted = filteredObjects.sorted { $0.isBrought && !$1.isBrought }
        NavigationStack {
            List {
                Section {
                    withAnimation {
                        //il problema con questa cosa è che i parametri si passano a tutte le view, devo vede come devo fa per ogni view
                        //altrimenti dovrei fare tipo che metto le categorie e poi faccio il check in che cosa sto
                        //il prooblema è che io non so che luogo l'utente usa capi, ceh devo checkare in che view sta, e come potrei fa
                        ForEach(objectsSorted) { obj in
                            HStack {
                                Button {
                                    withAnimation {
                                        obj.isBrought.toggle()
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: obj.isBrought ? "square" : "checkmark.square.fill").foregroundStyle(.primaryOrange).font(.system(size: 25))
                                        Text(obj.name)
                                    }
                                }
                            }.padding(6)
                            .swipeActions {
                                Button {
                                    modelContext.delete(obj)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .tint(.red)
                                }
                            }
                        }
                    }
                } header: {
                    objectToBring
                }.listSectionSeparator(.hidden, edges: .top)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .tint(.primaryOrange)
            .navigationTitle("Objects")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                               showObjectSheet = true
                           }) {
                               Image(systemName: "plus")
                                   .font(Font.system(.title2).weight(.bold))
                                   .foregroundStyle(.white)
                                   .font(.largeTitle)
                                   .frame(width: 75, height: 75)
                                   .background(LinearGradient(gradient: Gradient(colors: [.primaryOrange, .secondaryOrange]), startPoint: .top, endPoint: .bottom))
                                   .clipShape(Circle())
                                   .padding()
                                   .shadow(radius: 2.5)
                           }
                           .sheet(isPresented: $showObjectSheet) {
                              AddObjectView(location: location)
                           }
                }
            }
        }.tint(.primaryOrange)
    }
}

