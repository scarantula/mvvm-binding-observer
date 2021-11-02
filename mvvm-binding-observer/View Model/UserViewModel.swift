//
//  User.swift
//  mvvm-binding-observer
//
//  Created by user205198 on 11/2/21.
//
import SwiftyJSON

class Observable<T>{
    var value: T?{
        didSet{
            listeners.forEach{
                $0(value)
            }
        }
    }
    
    init(_ value: T?){
        self.value = value
    }
    
    private var listeners: [((T?) -> Void)] = []
    
    func bind(_ listener: @escaping (T?) -> Void){
        listeners.append(listener)
        listener(value)
    }
}

//struct User: Codable{
//    var name: String
//}

struct UserCellViewModel{
    var name: String
    
    init(json: JSON){
        name = json["name"].stringValue
    }
}


struct UserListViewModel{
    var users: Observable<[UserCellViewModel]> = Observable([])
    
}
