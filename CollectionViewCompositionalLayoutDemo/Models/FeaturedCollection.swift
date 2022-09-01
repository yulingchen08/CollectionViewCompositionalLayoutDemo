//
//  FeaturedCollection.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/1.
//

import Foundation
//{
//  "collections": [
//    {
//      "id": "9mp14cx",
//      "title": "Cool Cats",
//      "description": null,
//      "private": false,
//      "media_count": 6,
//      "photos_count": 5,
//      "videos_count": 1
//    }
//  ],
//
//  "page": 2,
//  "per_page": 1,
//  "total_results": 5,
//  "next_page": "https://api.pexels.com/v1/collections/featured/?page=3&per_page=1",
//  "prev_page": "https://api.pexels.com/v1/collections/featured?page=1&per_page=1"
//}

struct FeaturedCollection: Codable {
    
    
    var collections: [Collection]
    
    var page: Int
    var perPage: Int
    var totalResults: Int
    var nextPage: String
    var prevPage: String?
    
    enum CodingKeys: String, CodingKey {
        case collections
        case page = "page"
        case perPage = "per_page"
        case totalResults = "total_results"
        case nextPage = "next_page"
        case prevPage = "prev_page"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        collections = try container.decode([Collection].self, forKey: .collections)
        page = try container.decode(Int.self, forKey: .page)
        perPage = try container.decode(Int.self, forKey: .perPage)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        nextPage = try container.decode(String.self, forKey: .nextPage)
        prevPage = try container.decodeIfPresent(String.self, forKey: .prevPage)

    }
}

struct Collection: Codable {
    var id: String
    var title: String
    var description: String
    var `private`: Bool
    var mediaCount: Int
    var photosCount: Int
    var videoCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, `private`
        case mediaCount = "media_count"
        case photosCount = "photos_count"
        case videoCount = "videos_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        `private` = try container.decode(Bool.self, forKey: .private)
        mediaCount = try container.decode(Int.self, forKey: .mediaCount)
        photosCount = try container.decode(Int.self, forKey: .photosCount)
        videoCount = try container.decode(Int.self, forKey: .videoCount)
    }
    
}
