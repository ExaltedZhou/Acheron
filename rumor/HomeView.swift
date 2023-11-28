//
//  HomeView.swift
//  rumor
//
//  Created by Albert Zhou on 11/19/23.
//

import SwiftUI
import CloudKit
import os
import Combine

struct usCity:Identifiable{
    let id = UUID()
    let CityName:String
    let lt: Double
    let ln: Double
}
struct usState: Identifiable{
    let id = UUID()
    let StateName: String
    let cities: [usCity]
}

struct HomeView: View {
    @StateObject private var vm = PostViewModel()
    var userName: String
    @State private var searchText=""
    @State private var userInput=""
    @FocusState private var nameIsFocused:Bool
    @Environment(\.dismiss) var dismiss
    
    private let usStates:[usState]=[
        usState(StateName:"LA",cities:[usCity(CityName:"Baton Rouge",lt:30,ln:-91),
                                       usCity(CityName:"New Orleans",lt:30.07,ln:-89.93)]),
        usState(StateName:"TX",cities:[usCity(CityName:"Houston",lt:29.75,ln:-95.358)])]
    var body: some View {
        NavigationView{
            VStack{
                List(vm.filteredPosts){postMain in
                    NavigationLink{
                        PostDetail(subPost: postMain, userName:userName)
                    }
                label:{
                    postRow(postMain:postMain)
                    
                }
                }.navigationTitle("rumor")
                    .refreshable{
                        await vm.load(title:"home")
                    }.onAppear{
                        Task{
                            await vm.load(title:"home")
                        }
                    }
                    .accessibilityElement(children: .combine)
                    .toolbar{
                        Text("Hi, \(userName)")
                            .foregroundColor(.accentColor)
                    }
                Spacer()
                HStack(alignment:.bottom){
                    TextField("your post", text:$userInput)
                        .focused($nameIsFocused)
                        .foregroundColor(.accentColor)
                        .border(.secondary)
                    //  .padding()
                    
                    Menu{
                        ForEach(usStates){usState in
                            Menu(usState.StateName){
                                ForEach(usState.cities){
                                    city in
                                    let l="\(city.CityName) \(usState.StateName)"
                                    Button(city.CityName){
                                        vm.post.myLocation = l
                                        vm.post.lt = city.lt
                                        vm.post.ln = city.ln
                                    }
                                }
                            }
                        }
                    }label: {
                        Label("", systemImage: "location.north.fill")
                    }
                    Spacer()
                    Button(action:{
                        nameIsFocused=false
                        vm.post.title="home"
                        vm.post.postContent=userInput
                        vm.post.time=Date()
                        vm.post.user=userName
                        Task{
                            await vm.save()
                        }
                        userInput=""
                    }){
                        Image(systemName:"square.and.arrow.up")
                    }.disabled(userInput.isEmpty)
                }
                
            }.padding()
        }.navigationViewStyle(.stack)
            .searchable(text:$vm.searchText)
            .accessibilityLabel("search")
    }
}

#Preview {
    HomeView(userName: "rumor").environmentObject(PostViewModel())
}
