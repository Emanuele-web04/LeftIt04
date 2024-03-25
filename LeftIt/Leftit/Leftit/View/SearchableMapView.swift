//
//  ContentView.swift
//  Test_MapKit
//
//  Created by Emanuele Di Pietro on 24/03/24.
//
import SwiftData
import SwiftUI
import MapKit

struct SearchableMap: View {
    @State private var position = MapCameraPosition.automatic
    // 1
    @State private var searchResults = [SearchResult]()
    //2
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true
    
    @State private var showDetailSheet: Bool = false
    
    @StateObject var locationManager = LocationManager()
    
    //create a query loctions: [LocationItem]
    @Query var locations: [LocationItem]

    var body: some View {
        Map(position: $position, selection: $selectedLocation) {
            UserAnnotation()
        
            ForEach(searchResults) { result in
                Marker(result.item?.placemark.name ?? "", systemImage: "mappin.and.ellipse", coordinate: result.location)
                .tag(result)
            }
            //then here do a foreach of every locations, and pass the parameters to the marker
            ForEach(locations, id: \.self) { location in
                Marker(location.name, systemImage: "mappin.and.ellipse", coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            }.tint(.secondaryOrange)
        }
        .tint(LinearGradient(gradient: Gradient(colors: [Color.primaryViolet, Color.secondaryViolet]), startPoint: .top, endPoint: .bottom))
            .mapControlVisibility(.visible)
            .mapStyle(.standard(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapScaleView()
                MapCompass()
            }
            .sheet(isPresented: $showDetailSheet, content: {
                LocationDetailsView(selectedLocation: $selectedLocation, showDetailSheet: $showDetailSheet)
                    .presentationDetents([.height(500)])
                    .presentationBackground(.clear)
            })
        .onChange(of: selectedLocation) {
            showDetailSheet = true
            if showDetailSheet {
                isSheetPresented.toggle()
            }
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
