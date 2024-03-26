//
//  ContentView.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 20/03/24.
//
import SwiftData
import SwiftUI
import MapKit

struct CalendarTypeNumber: Identifiable {
    var id = UUID()
    var iconCalendar: Image
    var type: String
    var number: Int
    var color: Color
}

struct BlockSchedule: View {
    @Bindable var location: LocationItem
    var body: some View {
        ZStack{
            HStack(alignment: .top){
                VStack(alignment: .center){
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 30))
                        .foregroundStyle(.primary)
                        .padding(.bottom, 5)
                    Text(location.name)
                        .foregroundStyle(Color.primary)
                        .fontWeight(.medium)
                    
                }
            }.frame(maxWidth: .infinity)
                .frame(height: 800)
            .padding(20)
            
        }
        .background(.paleGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



class Block: Identifiable {
    
    var calendarTypeNumber = [
        CalendarTypeNumber(iconCalendar: Image(systemName: "briefcase.fill"), type: "Work", number: 0, color: Color.primary),
        CalendarTypeNumber(iconCalendar: Image(systemName:"dumbbell.fill"), type: "Gym", number: 0, color: Color.primary),
        CalendarTypeNumber(iconCalendar: Image(systemName:"heart.text.square.fill"), type: "Doctor", number: 0, color: Color.primary)
    ]
}



struct ContentView: View {
    
    @State private var showMap = false
    
    let gridLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2) // Adjust the spacing value as needed
    var blockObject = Block()
    @State private var searchText = ""
    
    @Query var locations: [LocationItem]
    
    @ViewBuilder
    var locationRightNow: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Location").foregroundStyle(.white).opacity(0.8).font(.caption)
                    Text("Home").foregroundStyle(.white).font(.title).fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "mappin.and.ellipse").foregroundStyle(.white).font(.largeTitle)
            }
            .padding(.horizontal, 30)
        }.cornerRadius(10)
    }
    

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading){
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(locations) { location in
                                BlockSchedule(location: location)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                } header: {
                    locationRightNow
                }.listRowSeparator(.hidden, edges: .all)
            }
            .navigationTitle("Locations")
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Add location")
                        }
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(50)
                        .padding(.vertical, 10)
                    }.frame(maxWidth: .infinity)
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink{
                        SearchableMap()
                            .ignoresSafeArea()
                    } label: {
                        HStack {
                            Image(systemName: "map.fill")
                        }
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(5)
                        .font(.title3)
                        .background(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(50)
                        .padding(.vertical, 10)
                    }.frame(maxWidth: .infinity)
                     
                       
                }
            }
        }.fontDesign(.rounded)
    }
}

#Preview {
    ContentView()
}
