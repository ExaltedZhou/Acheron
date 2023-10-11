//
//  IconView.swift
//  Acheron2023
//
//  Created by Albert Zhou on 10/8/23.
//
import CoreGraphics
import SwiftUI

struct ImageView: View {
    var body: some View {
        ZStack{
            Text("Acheron")
                .font(.title)
                .padding(6)
                .foregroundColor(.green)
        }.background(Color.white)
            .opacity(0.8)
            .cornerRadius(4.0)
            .padding(6)
    }
}
    
struct IconView: View{
    var body: some View{
        VStack{
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .imageScale(.small)
                .frame(width: 200, height: 100, alignment: .center)
                .clipped()
                .overlay(ImageView(),alignment:.leading)
        }
    }
}

#Preview {
    IconView()
}
