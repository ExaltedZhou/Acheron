//
//  ContentView.swift
//  Acheron2023
//
//  Created by Albert Zhou on 10/8/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        IconView()
        Spacer()
        VideoView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
