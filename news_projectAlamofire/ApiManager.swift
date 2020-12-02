//
//  ApiManager.swift
//  news_projectAlamofire
//
//  Created by Berker Vergi on 1.12.2020.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ApiManager  {
    
    static let shared = ApiManager()
    
    private init() {
        
    }
    
//    func fetchJsonFromApi() {
//        AF.request("http://newsapi.org/v2/top-headlines?"+"country=us&"+"apiKey=5369afde0eed4fba9cf5d96f50d35d29").responseString{
//            response in
//            switch(response.result){
//            case .success(let responseString):
//                print(responseString)
//
//                let newsResponse = ApiResponse(JSONString:"\(responseString)" )
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
    
    
    func newsRequest(completionHandler: @escaping (Int, Error?,[News]) -> ()) {
        
        AF.request("http://newsapi.org/v2/top-headlines?"+"country=us&"+"apiKey=5369afde0eed4fba9cf5d96f50d35d29",
            method: .get,
            encoding: JSONEncoding.default
        ).validate().responseObject { (response: AFDataResponse<ApiResponse>) in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 200:
                    do {
                        let result = try response.result.get()
                        completionHandler(1, nil,result.articles!)
                        print("Success")
                    }
                    catch {
                        fatalError("unable to convert data to JSON")
                    }
                default:
                  
                    print("error with response status: \(status)")
                }
            }
            
            
        }
    }
}
