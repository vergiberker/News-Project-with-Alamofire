//
//  ApiManager.swift
//  news_projectAlamofire
//
//  Created by Berker Vergi on 1.12.2020.
//

import Foundation
import Alamofire

class ApiManager  {
    
    
    static let shared = ApiManager()
    
    
   private init() {
        
    }
    func fetchJsonFromApi() {
        AF.request("http://newsapi.org/v2/top-headlines?"+"country=us&"+"apiKey=5369afde0eed4fba9cf5d96f50d35d29").responseString{
            response in
            switch(response.result){
            case .success(let responseString):
                print(responseString)
                
                let newsResponse = ApiResponse(JSONString:"\(responseString)" )
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
