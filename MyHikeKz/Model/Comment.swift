//
//  Comment.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 12.03.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Comment {
    let key: String
    let email: String
    let comment: String
    let date: String
    let page: String
    
    let ref: DatabaseReference?
    
    init(email: String, comment: String, date: String = "",key: String = "",page: String = "") {
        self.key = key
        self.email = email
        self.comment = comment
        self.date = date
        self.ref = nil
        self.page = page
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        email = snapshotValue["email"] as! String
        comment = snapshotValue["comment"] as! String
        date = snapshotValue["date"] as! String
        ref = snapshot.ref
        page = snapshotValue["page"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "email": email,
            "comment": comment,
            "date": date,
            "page": page
            
        ]
    }
    
}
struct News {
    let key: String
    let name: String
    let date: String
    let place: String
    let other: String
    let telephone: String
    
    let ref: DatabaseReference?
    
    init(name: String, date: String, key: String = "",place: String = "",other: String = "",telephone: String = "") {
        self.key = key
        self.date = date
        self.name = name
        self.ref = nil
        self.place = place
        self.other = other
        self.telephone = telephone
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        date = snapshotValue["date"] as! String
        ref = snapshot.ref
        place = snapshotValue["place"] as! String
        other = snapshotValue["other"] as! String
        telephone = snapshotValue["telephone"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "date": date,
            "place": place,
            "other": other,
            "telephone": telephone
            
        ]
    }
    
}
