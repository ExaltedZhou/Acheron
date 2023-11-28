//
//  MapView.swift
//  rumor
//
//  Created by Albert Zhou on 11/20/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    var lt:Double
    var ln:Double
   @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.4515, longitude: -91.1871), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    struct Marker:Identifiable{
        let id=UUID()
        var location:MapMarker
    }
    var body: some View {
        let coordinate=CLLocationCoordinate2D(latitude:lt, longitude: ln)
        let markers = [Marker(location:MapMarker(coordinate:coordinate))]
            
        Map(coordinateRegion: $mapRegion,annotationItems: markers){marker in marker.location}
      //  .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MapView(lt: 30.4515, ln: -91.1971)
}
