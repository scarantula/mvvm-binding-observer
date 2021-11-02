//
//  APIManager.swift
//  demo-alamofire
//
//  Created by user205198 on 10/31/21.
//
import SwiftyJSON
import Alamofire

typealias SuccessBlock = (JSON) -> Void
typealias ErrorBlock = (Error) -> Void

class APIManager{
    
    static var singleton = APIManager()
    
    var successResponse: SuccessBlock!
    var errorResponse: ErrorBlock!
    
    
    init(){}
    
    
    func callAPIRequest(url: String, successCompletion: @escaping SuccessBlock, errorCompletion: @escaping ErrorBlock){
        AF.request(url, method: .get).responseJSON { response in
            if let error = response.error{
                errorCompletion(error)
                
            }
            else{
                if let responseData = response.data{
                    let json = JSON(responseData)
                    successCompletion(json)
                }
            }
        }
    }
    
}
