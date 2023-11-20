//
//  postRow.swift
//  rumor
//
//  Created by Albert Zhou on 11/19/23.
//

import SwiftUI

struct postRow: View {
    var postMain:post
    var body: some View {
        VStack(alignment: .leading){
            Text(postMain.postContent)
            HStack {
                Text(postMain.time.formatted(date:.numeric, time: .complete))
                    .font(.system(size:9)).italic()
                Spacer()
                Text("\(postMain.user)")
                    .font(.system(size:9)).italic()
            }
        }.padding()
    }
}

#Preview {
    postRow(postMain: post.samplePost[0]).environmentObject(posts())
}
