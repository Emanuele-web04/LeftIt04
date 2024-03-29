//
//  AddObjectView.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 27/03/24.
//

import SwiftUI
import SwiftData

struct AddObjectView: View {
    @State private var object = ObjectItem()
    @Bindable var location: LocationItem
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @FocusState var isTextFieldFocused
    
    var body: some View {
        NavigationStack {
            List{
                Section {
                    TextField("Add Object", text: $object.name)
                        .focused($isTextFieldFocused)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        object.id = location.name
                        print(object.id)
                        modelContext.insert(object)
                        object.isBrought = true
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                    .tint(.primaryOrange)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

