//
//  ObjectsView.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 26/03/24.
//

import SwiftUI
import SwiftData

struct ObjectsView: View {
    
    @ViewBuilder
    var locationRightNow: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .frame(maxWidth: .infinity)
                .frame(height: 110)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.primaryOrange, .secondaryOrange]), startPoint: .top, endPoint: .bottom))
            HStack {
                VStack(alignment: .leading) {
                    Text("Before leaving:").foregroundStyle(.white).opacity(0.8).font(.caption)
                    Text("5 objects").foregroundStyle(.white).font(.title).fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "door.right.hand.open").foregroundStyle(.white).font(.largeTitle)
            }
            .padding(.horizontal, 30)
        }.cornerRadius(10)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(0..<5) { num in
                        HStack {
                            Image(systemName: "app").foregroundStyle(.primaryOrange).font(.system(size: 25))
                            Text("Object" + "\(num)")
                        }.padding(6)
                    }
                } header: {
                    locationRightNow
                }.listSectionSeparator(.hidden, edges: .top)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .tint(.primaryOrange)
            .navigationTitle("Objects")
        }.tint(.primaryOrange)
    }
}

#Preview {
    ObjectsView()
}
