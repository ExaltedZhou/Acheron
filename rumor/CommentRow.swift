//
//  CommentRow.swift
//  rumor
//
//  Created by Albert Zhou on 11/27/23.
//

import SwiftUI

struct CommentRow: View {
    var postMain:post
    var body: some View {
        VStack(alignment: .leading){
            Text(postMain.postContent)
                .font(.system(size:28))
            HStack {
                Text(postMain.time.formatted(date:.numeric, time: .complete))
                    .font(.system(size:9)).italic()
                Spacer()
                Text("\(postMain.user)")
                    .font(.system(size:9)).italic()
            }
        }.padding()    }
}

#Preview {
    CommentRow(postMain: post.emptyPost)
}
