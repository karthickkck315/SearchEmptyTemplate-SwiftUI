//
//  ContentView.swift
//  SearchEmptyTemplate-SwiftUI
//
//  Created by Kambaa on 31/01/24.
//

import SwiftUI

struct ContentView: View {
    
    // @State private var superHeros = ["Super Man","Iron Man","Hulk","Thanos","Root"]
    @State private var superHeros : [String] = []
    @State private var searchTerm = ""
    
    var filterHeros: [String] {
        guard !searchTerm.isEmpty else {return superHeros}
        return superHeros.filter{$0.localizedCaseInsensitiveContains(searchTerm)}
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if superHeros.isEmpty {
                    //ContentUnavailableView("No Data!", systemImage:"person.slash" , description: Text("Data not found from List"))
                    ContentUnavailableView(label: {
                        VStack(spacing: 20) {
                            Image(.mans)
                                .clipShape(.circle)
                            
                            Text("No Data")
                                .bold()
                        }
                    }, description: {
                        Text("Tap the button below to refresh")
                            .italic()
                            .foregroundStyle(.secondary)
                        
                    }, actions: {
                        Button("Refresh") {
                            //
                            superHeros = ["Super Man","Iron Man","Hulk","Thanos","Root"]
                        }
                        .buttonStyle(.bordered)
                        
                    })
                } else {
                    List(filterHeros,id: \.self) { name in
                        Text(name)
                    }
                    .background(.clear)
                    .foregroundColor(.blue)
                    .searchable(text: $searchTerm)
                    .overlay{
                        if filterHeros.isEmpty {
                            ContentUnavailableView.search(text: searchTerm)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
