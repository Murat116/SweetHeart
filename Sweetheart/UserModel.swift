//
//  UserModel.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import RealmSwift
import Foundation

@objcMembers
class UserModel: Object {
    dynamic var id = UUID().uuidString
    private(set) dynamic var phone: String = ""
    dynamic var name: String?
    dynamic var instagram: String?
    dynamic var coins: Int = 0 //купленные бабки
    dynamic var valentines: Int = 0 //твои валентинки
    dynamic var imageData: Data?
    
    dynamic var votes: [String: Int] = [:]
    
    private(set) dynamic var typeInt: Int = 0
    
    var type: UserType {
        get{
            return UserType(rawValue: self.typeInt) ?? .another
        }
        set{
            self.typeInt = newValue.rawValue
        }
    }
    
    static func createUser(phone: String) -> UserModel{
        let user = UserModel()
        user.phone = phone
        return user
    }
}

struct Datamanager {
    static var shared = Datamanager()
    
    var realm: Realm? = {
        let queue: DispatchQueue = DispatchQueue.main
        do{
            return try Realm(queue: queue)
        }catch{
            print(error.localizedDescription, "ошибка в получении Realm")
            return nil
        }
    }()
    
    var curentUser: UserModel! {
        get{
            return self.realm?.objects(UserModel.self).filter("\(#keyPath(UserModel.typeInt)) = %@", 0).first!
        }
    }
    
    var anotherUsersSet: Results<UserModel>?{
        get{
            return self.realm?.objects(UserModel.self).filter("\(#keyPath(UserModel.typeInt)) = %@", 1)
        }
    }
    
    var anotherUsers: [UserModel] {
        get{
            guard let usersSet = self.anotherUsersSet else { return []}
            var array = Array(usersSet)
            array.sort{$0.valentines > $1.valentines}
            return array
        }
    }
    
}


enum UserType: Int{
    case curent = 0
    case another
}
