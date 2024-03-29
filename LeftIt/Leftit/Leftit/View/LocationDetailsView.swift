//
//  LocationDetailsView.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 25/03/24.
//

import MapKit
import SwiftUI
import SwiftData

struct LocationDetailsView: View {
    
    @State private var lookAroundScene: MKLookAroundScene?
    @Binding var selectedLocation: SearchResult?
    @Binding var showDetailSheet: Bool
    @Environment(\.dismiss) var dismiss
  
    @State var location = LocationItem()
    @Environment(\.modelContext) var modelContext
    
    //create a function that check wether a exact name already extst and show, delete location instead of add location

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading) {
                    Text(selectedLocation?.item?.placemark.name ?? "")
                        .lineLimit(2)
                        .foregroundStyle(.primary)
                        .font(.title)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(selectedLocation?.item?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                Spacer()
                Button {
                    showDetailSheet.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.gray)
                }
            }
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash.fill")
            }
            
            HStack {
                Button {
                    if let mapSelection = selectedLocation {
                        mapSelection.item?.openInMaps()
                    }
                } label: {
                    Text("Open in Maps")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.blue)
                }.cornerRadius(12.0)
            }
            HStack {
                Button {
                    //qui io devo passare i parametri, such as title etc
                    if let selectedLocation = selectedLocation {
                        location.name = selectedLocation.item?.placemark.name ?? ""
                        location.title = selectedLocation.item?.placemark.title ?? ""
                        location.latitude = selectedLocation.location.latitude
                        location.longitude = selectedLocation.location.longitude
                        //non devo fare insert perchè lo devo fare dopo nella sheet view che compila le cose
                        modelContext.insert(location)
                    }
                    print(location.name)
                    showDetailSheet.toggle()
                    //chiudi questo e apri quello che ti fa mettere l'elenco
                } label: {
                    Label("Add location", systemImage: "paperplane.circle.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.primaryViolet, Color.secondaryViolet]), startPoint: .top, endPoint: .bottom))
                }.cornerRadius(12.0)
            }
            
        }
        .padding()
        .onAppear {
            fetchLookAroundPreview()
        }
        .onChange(of: selectedLocation) {
            fetchLookAroundPreview()
        }
        .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 500)
                    .background(.paleGray)
                    .clipShape(.rect(cornerRadius: 20))
                    .ignoresSafeArea()
    }
}

extension LocationDetailsView {
    func fetchLookAroundPreview() {
        if let selectedLocation = selectedLocation {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: (selectedLocation.item)!)
                lookAroundScene = try? await request.scene
            }
        }
    }
}
