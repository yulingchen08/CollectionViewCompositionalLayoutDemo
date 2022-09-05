//
//  PhotoResource.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/5.
//

import Foundation


struct CuratedPhoto: Codable {
         
    let id: Int
    //var page: Int
    var perPage: Int
    var photos: [Photo]
    var totalResults: Int
    var nextPage: String
    var prevPage: String
    
    enum CodingKeys: String, CodingKey {
        case photos
        case id = "page"
        case perPage = "per_page"
        case totalResults = "total_results"
        case nextPage = "next_page"
        case prevPage = "prev_page"
    }
    
    struct Photo: Codable {
        var id: Int
        var width: Int
        var height: Int
        var url: String
        var photographer: String
        var photographerUrl: String
        var photographerId: Int
        var avgColor: String
        var src: Src
        var liked: Bool
        var alt: String
        
        enum CodingKeys: String, CodingKey {
            case id, width, height, url, photographer, src, liked, alt
            case photographerUrl = "photographer_url"
            case photographerId = "photographer_id"
            case avgColor = "avg_color"
        }
        
        struct Src: Codable {
            var original: String
            var large2x: String
            var large: String
            var medium: String
            var small: String
            var portrait: String
            var landscape: String
            var tiny: String
        }
    }
   
}
