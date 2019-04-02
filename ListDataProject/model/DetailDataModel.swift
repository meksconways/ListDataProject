//
//  DetailDataModel.swift
//  ListDataProject
//
//  Created by macbook  on 2.04.2019.
//  Copyright © 2019 ibrahimballibaba. All rights reserved.
//

import Foundation

/**
 {
 "postId": 1,
 "id": 1,
 "name": "id labore ex et quam laborum",
 "email": "Eliseo@gardner.biz",
 "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
 },
 */

struct DetailModelRootClass : Codable {
    
    let body : String?
    let email : String?
    let id : Int?
    let name : String?
    let postId : Int?
    
    enum CodingKeys: String, CodingKey {
        case body = "body"
        case email = "email"
        case id = "id"
        case name = "name"
        case postId = "postId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decodeIfPresent(String.self, forKey: .body)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
    }
    
}

