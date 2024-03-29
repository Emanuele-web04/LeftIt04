//
//  SheetView.swift
//  Test_MapKit
//
//  Created by Emanuele Di Pietro on 24/03/24.
//

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct SheetView: View {
    @State private var locationService = LocationService(completer: .init())
    @State private var search: String = ""
    // 1
    @Binding var searchResults: [SearchResult]

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search for a location", text: $search)
                    .autocorrectionDisabled()
                    // 2
                    .onSubmit {
                        Task {
                            searchResults = (try? await locationService.search(with: search)) ?? []
                        }
                    }
            }
            .modifier(TextFieldGrayBackgroundColor()).tint(.primaryViolet)

            Spacer()

            List {
                ForEach(locationService.completions) { completion in
                    // 3
                    Button(action: { didTapOnCompletion(completion) }) {
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse.circle.fill").foregroundStyle(.white, .primaryViolet).font(.system(size: 20))
                                    Text(completion.title)
                                        .font(.headline)
                                        .fontDesign(.rounded)
                                }
                                Text(completion.subTitle)
                                // What can we show?
                                if let url = completion.url {
                                    Link(url.absoluteString, destination: url)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .onChange(of: search) {
            locationService.update(queryFragment: search)
        }
        .ignoresSafeArea()
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(100), .large])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .large))
    }

    // 4
    private func didTapOnCompletion(_ completion: SearchCompletions) {
        Task {
            if let singleLocation = try? await locationService.search(with: "\(completion.title) \(completion.subTitle)").first {
                searchResults = [singleLocation]
            }
        }
    }
}
struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(18)
            .background(.gray.opacity(0.1))
            .cornerRadius(18)
            .foregroundColor(.primary)
    }
}
