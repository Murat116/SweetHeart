//
//  UserModel.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import RealmSwift
import Foundation

class UserModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc private(set) dynamic var phone: String = ""
    @objc dynamic var name: String?
    @objc dynamic var instagram: String?
    @objc dynamic var coins: Int = 0 //купленные бабки
    @objc dynamic var valentines: Int = 0 //твои валентинки
    @objc dynamic var placeInTop: Int = 0
    @objc dynamic var imageData: Data?
    
    @objc dynamic var votesData: Data = Data()
    
    var votes: [String: Int] = [:]
    
    @objc private(set) dynamic var typeInt: Int = 0
    
    var type: UserType {
        get{
            return UserType(rawValue: self.typeInt) ?? .another
        }
        set{
            self.typeInt = newValue.rawValue
        }
    }
    
    fileprivate static func createUser(phone: String, type: UserType) -> UserModel{
        let user = UserModel()
        user.phone = phone
        user.type = type
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
            return self.realm?.objects(UserModel.self).filter("\(#keyPath(UserModel.typeInt)) = %@", 0).first ?? UserModel()
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
    
    func createUser(with phone: String, type: UserType){
        let user = UserModel.createUser(phone: phone, type: type)
        do{
            try realm?.write{
                self.realm?.add(user)
            }
        }catch{
            print(error)
        }
    }
    
    internal  func updateProperty(of user: UserModel, value: Any, for key: String){
        do{
            try self.realm?.write {
                user.setValue(value, forKey: key)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
}


enum UserType: Int{
    case curent = 0
    case another
}
