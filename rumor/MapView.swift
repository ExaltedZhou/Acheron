//
//  MapView.swift
//  rumor
//
//  Created by Albert Zhou on 11/20/23.
//

import SwiftUI
import MapKit
//extension CLLocationCoordinate2D{
   // static let BatonRouge = CLLocationCoordinate2D(latitude: 30.4515, longitude: -91.1871)

//}
struct MapView: View {
   @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.4515, longitude: -91.1871), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var body: some View {
            Map(coordinateRegion: $mapRegion).navigationTitle("Map")
    }
}

#Preview {
    MapView()
}
