//
//  Model.swift
//  MyHikeKz
//
//  Created by Dayana Marden on 18.02.18.
//  Copyright © 2018 Dayana Marden. All rights reserved.
//
import Foundation
struct Places: Decodable {
    var title : String
    var photo: [String]
    var location_text : String
    var desc : String
    var level : String
    var lat : Double
    var long : Double
}

struct Comm {
    var date: String
    var email: String
    var comment: String
    var page: String
}

