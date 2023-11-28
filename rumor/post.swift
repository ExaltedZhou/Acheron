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
    @Published var posts: [post] = [post(title:"home", postContent:"Welcome", time:Date(), user:"rumor", myLocation:"Baton Rouge LA", lt:30,ln:-91)]
}
struct post:Identifiable{
    var id = UUID()
    var title: String = ""
    var postContent: String = ""
    var time = Date()
    var user: String=""
    var recordID: CKRecord.ID?
    var myLocation: String=""
    var lt:Double=0.0
    var ln:Double=0.0
}
enum postRecordKeys:String{
    case title
    case postContent
    case time
    case user
    case myLocation
    case lt
    case ln
}
extension post{
    var record: CKRecord{
        let record = CKRecord(recordType:"post")
        record[postRecordKeys.title.rawValue]=title
        record[postRecordKeys.postContent.rawValue]=postContent
        record[postRecordKeys.time.rawValue]=time
        record[postRecordKeys.user.rawValue]=user
        record[postRecordKeys.myLocation.rawValue]=myLocation
        record[postRecordKeys.lt.rawValue]=lt
        record[postRecordKeys.ln.rawValue]=ln

        return record
    }
}
extension post{
    init? (from record: CKRecord){
        let title = record[postRecordKeys.title.rawValue]
        let postContent = record[postRecordKeys.postContent.rawValue]
        let time = record[postRecordKeys.time.rawValue]
        let user = record[postRecordKeys.user.rawValue]
        let myLocation = record[postRecordKeys.myLocation.rawValue]
        let lt = record[postRecordKeys.lt.rawValue]
        let ln = record[postRecordKeys.ln.rawValue]

        self = .init (title:title as! String, postContent: postContent as! String, time: time as! Date, user: user as! String,
                      myLocation: myLocation as! String, lt:lt as! Double, ln:ln as! Double)
    }
}
extension post{
    static var emptyPost: post{
        post(title:"",postContent:"", time: Date(), user:"",myLocation: "",lt:0.0,ln: 0.0)
    }
    static let samplePost: [post] =
    [post(title:"home",postContent:"Welcome",time:Date(),user:"rumor",myLocation: "Baton Rouge, LA",lt:30.1,ln:-91)]
}
