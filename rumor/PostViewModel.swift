//
//  PostViewModel.swift
//  rumor
//
//  Created by Albert Zhou on 11/19/23.
//

import Foundation
import CloudKit
import Combine

@MainActor
class PostViewModel:ObservableObject{
    @Published var searchText:String=""
    @Published private(set) var postMains:[post]=[]
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingName = false
    @Published private(set) var isSaving = false
    @Published var post:post = .init(
        title:"",
        postContent:"",
        time:Date(),
        user: "",
        myLocation:"",
        lt:0.0,
        ln:0.0
    )
    var filteredPosts:[post]{
        let df = DateFormatter()
        df.dateFormat = "MM/dd/YYYY"
        guard !searchText.isEmpty else{return postMains}
        return postMains.filter{$0.user.contains(searchText)||$0.postContent.contains(searchText)||df.string(from:$0.time).contains(searchText)
        }
    }
    
    func load(title:String) async{
        isLoading = true
        do{
            postMains = try await CKpost.fetch(title:title)
        }catch{
            
        }
        isLoading=false
    }
    
    func loadName(user:String) async{
        isLoadingName = true
        do{
            postMains = try await CKpost.fetch(user:user)
        }catch{
            
        }
        isLoadingName=false
    }
    
    func save() async{
        isSaving=true
        do{
            try await CKpost().save(post.record)
        }catch{
            
        }
        isSaving=false
    }
}
