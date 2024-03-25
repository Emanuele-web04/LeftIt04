//
//  ContentView.swift
//  Test_MapKit
//
//  Created by Emanuele Di Pietro on 24/03/24.
//

import SwiftUI
import MapKit

struct SearchableMap: View {
    @State private var position = MapCameraPosition.automatic
    // 1
    @State private var searchResults = [SearchResult]()
    //2
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true

    var body: some View {
        // 3
        Map(position: $position, selection: $selectedLocation) {
            // 4
            UserAnnotation()
            ForEach(searchResults) { result in
                Marker(coordinate: result.location) {
                    Image(systemName: "mappin")
                }
                .tag(result)
            }
        }
        .tint(LinearGradient(gradient: Gradient(colors: [Color.primaryViolet, Color.secondaryViolet]), startPoint: .top, endPoint: .bottom))
            .mapControlVisibility(.visible)
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapScaleView()
                MapCompass()
            }
        // 5
        .onChange(of: selectedLocation) {
            isSheetPresented = selectedLocation == nil
        }
        // 6
        .onChange(of: searchResults) {
            if let firstResult = searchResults.first, searchResults.count == 1 {
                selectedLocation = firstResult
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView(searchResults: $searchResults)
        }
    }
}
