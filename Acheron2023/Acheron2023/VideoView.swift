//
//  VideoView.swift
//  Acheron2023
//
//  Created by Albert Zhou on 10/8/23.
//

import AVKit
import SwiftUI


struct VideoView: View {
    @State var player = AVPlayer(url:Bundle.main.url(forResource:"IMG_5206",withExtension:"mp4")!)
    var body: some View {
        VideoPlayer(player: player, videoOverlay:{
           VStack(alignment: .leading) {
                Text("math")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding(.all, 10)
                Spacer()
            }
        })
        .frame(width:300, height:400,alignment: .center)
    }
}

#Preview {
    VideoView()
}
