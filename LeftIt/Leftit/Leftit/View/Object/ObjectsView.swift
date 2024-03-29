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
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var showConfirmationAlert = false
    @State private var showObjectSheet = false

    @ViewBuilder
    var objectToBring: some View {
        let countObjects = filteredObjects.filter({ $0.isBrought }).count
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
                        ForEach(objectsSorted, id: \.self) { obj in
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
            .alert("Are you sure you want to delete this location?", isPresented: $showConfirmationAlert, actions: {
                           Button("Delete", role: .destructive) {
                               // Perform the deletion
                               modelContext.delete(location)
                               dismiss()
                           }
                           Button("Don't Delete", role: .cancel) { }
                       }, message: {
                           Text("This action cannot be undone.")
                       })
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .tint(.secondaryOrange)
            .navigationTitle(location.name).lineLimit(2)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                               showObjectSheet = true
                           }) {
                               HStack {
                                   Image(systemName: "key.fill")
                                   Text("Add object")
                               }
                               .fontWeight(.medium)
                               .foregroundColor(.white)
                               .padding(12)
                               .background(LinearGradient(gradient: Gradient(colors: [.primaryOrange, .secondaryOrange]), startPoint: .top, endPoint: .bottom))
                               .cornerRadius(14)
                               .padding(.vertical, 10)
                           }.frame(maxWidth: .infinity)
                           .sheet(isPresented: $showObjectSheet) {
                              AddObjectView(location: location)
                           }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        showConfirmationAlert = true
                    } label: {
                        Image(systemName: "trash.circle").tint(.primaryOrange)
                    }
                    
                }
                
            }
        }
    }
}

