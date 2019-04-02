//
//  ListDataModel.swift
//  ListDataProject
//
//  Created by macbook  on 2.04.2019.
//  Copyright © 2019 ibrahimballibaba. All rights reserved.
//

import Foundation

/**
 
 {
 "albumId": 1,
 "id": 1,
 "title": "accusamus beatae ad facilis cum similique qui sunt",
 "url": "https://via.placeholder.com/600/92c952",
 "thumbnailUrl": "https://via.placeholder.com/150/92c952"
 },
 */
struct FirstDataModelRootClass : Codable {
    
    let albumId : Int?
    let id : Int?
    let thumbnailUrl : String?
    let title : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case thumbnailUrl = "thumbnailUrl"
        case title = "title"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try values.decodeIfPresent(Int.self, forKey: .albumId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        thumbnailUrl = try values.decodeIfPresent(String.self, forKey: .thumbnailUrl)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}

