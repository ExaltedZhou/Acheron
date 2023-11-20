//
//  HomeView.swift
//  rumor
//
//  Created by Albert Zhou on 11/19/23.
//

import SwiftUI
import CloudKit
import os

struct HomeView: View {
    @StateObject private var vm = PostViewModel()
    var userName: String
    @State private var searchText=""
    @State private var userInput=""
    @FocusState private var nameIsFocused:Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            NavigationView{
                List(vm.postMains){postMain in
                    postRow(postMain:postMain)
                }.navigationTitle("rumor")
                    .refreshable{
                        await vm.load()
                    }.onAppear{
                        Task{
                            await vm.load()
                        }
                    }
                    .accessibilityElement(children: .combine)
                    .toolbar{
                        HStack{
                            Text("Hi, \(userName)")
                            Spacer()
                            NavigationLink{
                                MapView()
                            } label:{
                                Label("", systemImage: "location.circle.fill")
                            }
                            Spacer()
                          //  NavigationLink{
                          //      ContentView()
                        //    }label:{Text("signout")}
                        }
                        Text(searchText)
                    }.searchable(text:$searchText)
                    .accessibilityLabel("search")
                Spacer()
            }
            Spacer()
            HStack(alignment:.bottom){
                TextField("your post", text:$userInput)
                    .focused($nameIsFocused)
                    .foregroundColor(.accentColor)
                    .border(.secondary)
                    .padding()
                Button(action:{
                    nameIsFocused=false
                    vm.post.postContent=userInput
                    vm.post.time=Date()
                    vm.post.user=userName
                    Task{
                        await vm.save()
                        dismiss()
                    }
                    userInput=""
                }){
                    Image(systemName:"paperplane.fill")
                }.padding()
            }
        }
    }
}

#Preview {
    HomeView(userName: "rumor").environmentObject(posts())
}
