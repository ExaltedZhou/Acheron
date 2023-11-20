//
//  post.swift
//  rumor
//
//  Created by Albert Zhou on 11/19/23.
//

import Foundation
import Combine
import CloudKit

class posts: ObservableObject{
    @Published var posts: [post] = [post(postContent:"Welcome", time:Date(), user:"rumor")]
}
struct post:Identifiable{
    var id = UUID()
    var postContent: String = ""
    var time = Date()
    var user: String=""
    var recordID: CKRecord.ID?
}
enum postRecordKeys:String{
    case postContent
    case time
    case user
}
extension post{
    var record: CKRecord{
        let record = CKRecord(recordType:"post")
        record[postRecordKeys.postContent.rawValue]=postContent
        record[postRecordKeys.time.rawValue]=time
        record[postRecordKeys.user.rawValue]=user
        return record
    }
}
extension post{
    init? (from record: CKRecord){
        let postContent = record[postRecordKeys.postContent.rawValue]
        let time = record[postRecordKeys.time.rawValue]
        let user = record[postRecordKeys.user.rawValue]
        self = .init (postContent: postContent as! String, time: time as! Date, user: user as! String)
    }
}
extension post{
    static var emptyPost: post{
        post(postContent:"", time: Date(), user:"")
    }
    static let samplePost: [post] =
    [post(postContent:"Welcome",time:Date(),user:"rumor")]
}
