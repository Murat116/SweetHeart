//
//  UserModel.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import RealmSwift
import Foundation
import UIKit

class UserModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc private(set) dynamic var phone: String = ""
    @objc dynamic var name: String?
    @objc dynamic var instagram: String?
    @objc dynamic var coins: Int = 0 //купленные бабки
    @objc dynamic var valentines: Int = 0 //твои валентинки
    @objc dynamic var placeInTop: Int = 0
    @objc dynamic var imageData: Data?
    
    @objc dynamic var votesData: Data?
    
    
    @objc private(set) dynamic var typeInt: Int = 0
    
    var type: UserType {
        get{
            return UserType(rawValue: self.typeInt) ?? .another
        }
        set{
            self.typeInt = newValue.rawValue
        }
    }
    
    static func createUser(phone: String, id: String? = nil, type: UserType) -> UserModel{
        let user = UserModel()
        user.phone = phone
        user.type = type
        if id != nil {
            user.id = id!
        }
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
    
    var curentUser: UserModel? {
        get{
            return self.realm?.objects(UserModel.self).filter("\(#keyPath(UserModel.typeInt)) = %@", 0).first 
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
            
            if self.curentUser != nil {
                array.append(self.curentUser!)
            }

            
            array.sort{$0.valentines > $1.valentines}
            
            return array
        }
    }
    
    var name = ["Лера", "Кира", "Даша", "Дина", "Азалия","Геляна", "Александр"]
    var inst = ["@pepa_desh", "@dinaraaach", "@_star.set_", "@miibragimova", "@wins_app", "@dkitt", "@pepa_desh"]
    
    
    @discardableResult
    func createUser(with phone: String, type: UserType, complition: ((Bool) -> ())? = nil) -> UserModel{
        let user = UserModel.createUser(phone: phone, type: type)
        do{
            try realm?.write{
                self.realm?.add(user)
                complition?(true)
            }
        }catch{
            print(error)
            complition?(false)
        }
        return user
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



extension Data {
    
    var jsonDictionary: [String:Any]? {
        guard self.count > 0 else { return [String:Any]() }
        do {
            return try JSONSerialization.jsonObject(with: self ) as? [String:Any]
        } catch {
            return nil
        }
    }
    
    var rangeDictionary: [NSRange:String]? {
        guard self.count > 0 else { return [NSRange:String]() }
        do {
            return try JSONSerialization.jsonObject(with: self ) as? [NSRange:String]
        } catch {
            return nil
        }
    }
}

extension Dictionary{
    var jsonData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self )
        } catch {
            return nil
        }
    }
}
