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
    @Published private(set) var postMains:[post]=[]
    @Published private(set) var isLoading = false
    @Published private(set) var isSaving = false
    @Published var post:post = .init(
        postContent:"",
        time:Date(),
        user: "")
    func load() async{
        isLoading = true
        do{
            postMains = try await CKpost.fetch()
        }catch{
            
        }
        isLoading=false
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
