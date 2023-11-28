//
//  PostDetail.swift
//  rumor
//
//  Created by Albert Zhou on 11/27/23.
//

import SwiftUI

struct PostDetail: View {
    var subPost:post
    @ObservedObject private var vm = PostViewModel()
    var userName:String
    @State private var searchText = ""
    @State private var userInput = ""
    @FocusState private var nameIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    private let usStates:[usState]=[
        usState(StateName:"LA",cities:[usCity(CityName:"Baton Rouge",lt:30,ln:-91),
                                       usCity(CityName:"New Orleans",lt:30.07,ln:-89.93)]),
        usState(StateName:"TX",cities:[usCity(CityName:"Houston",lt:29.75,ln:-95.358),
                                       usCity(CityName: "Austin", lt: 30.3, ln: 97.7)]),
        usState(StateName: "NY", cities: [usCity(CityName: "New York City", lt: 40.73, ln: 73.94)]),
        usState(StateName: "CA", cities: [usCity(CityName: "Los Angeles", lt: 34, ln: 118.2)])]
    
    var body: some View {
        VStack {
            MapView(lt: subPost.lt, ln: subPost.ln).frame(height:150)
            CommentRow(postMain:subPost)
                    List(vm.filteredPosts){postMain in
                        postRow(postMain:postMain)
                    }.navigationTitle("Comments")
                        .refreshable{
                            await vm.load(title:"\(subPost.postContent)\(subPost.time)")
                        }.onAppear{
                            Task{
                                await vm.load(title:"\(subPost.postContent)\(subPost.time)")
                            }
                        }
                        .accessibilityElement(children: .combine)
                        .toolbar{
                            Text("Hi, \(userName)")
                                .foregroundColor(.accentColor)
                        }.searchable(text:$vm.searchText)
                        .accessibilityLabel("search")
       
        Spacer()
            HStack(alignment:.bottom){
                TextField("your post", text:$userInput)
                    .focused($nameIsFocused)
                    .foregroundColor(.accentColor)
                    .border(.secondary)
                 //   .padding()
                
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
                    
                }label:{
                    Label("",systemImage: "location.north.fill")
                }
               // Spacer()
                Button(action:{
                    nameIsFocused=false
                    vm.post.title="\(subPost.postContent)\(subPost.time)"
                    vm.post.postContent=userInput
                    vm.post.time=Date()
                    vm.post.user=userName
                    Task{
                        await vm.save()
                    }
                    userInput=""
                }){
                    Image(systemName:"arrowshape.up.circle.fill")
                }.disabled(userInput.isEmpty)
            }.padding().navigationTitle("Comments")
        }
    }
}

#Preview {
    PostDetail(subPost: post.emptyPost, userName: "rumor")
}
