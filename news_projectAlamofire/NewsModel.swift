//
//  Model.swift
//  news_projectAlamofire
//
//  Created by Berker Vergi on 1.12.2020.
//

import Foundation
import ObjectMapper


class ApiResponse: Mappable {
    
    var articles : [News]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        articles <- map["articles"]
    }
    
    
}



class News: Mappable {
    
    var description : String?
    var title : String?
    var author: String?
    var url : URL?
    var urlToImage : String?
    var content : String?
    var totalResults : Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        author <- map["author"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        content <- map["content"]
        totalResults <- map["totalResults"]
    }
}
