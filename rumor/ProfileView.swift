//
//  ProfileView.swift
//  rumor
//
//  Created by Albert Zhou on 11/27/23.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    @ObservedObject var vm = PostViewModel()
    var userName:String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Profile")
                .font(.headline)
            Text("Name: \(userName)")
            List(vm.postMains){
                postMain in
                postRow(postMain: postMain)
            }
            .refreshable {
                await vm.loadName(user:userName)
            }
            .onAppear{
                Task{
                    await vm.loadName(user:userName)
                }
            }
            .accessibilityElement(children: .combine)
        }.padding()
            .navigationTitle("Profile")
            
        
    }
}

#Preview {
    ProfileView(userName: "rumor")
}
