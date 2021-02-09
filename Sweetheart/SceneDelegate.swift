//
//  SceneDelegate.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var navigtionController: UINavigationController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = Datamanager.shared.curentUser == nil ? PhoneVC() : MainVC()
        self.getUser()
        
        self.window?.overrideUserInterfaceStyle = .light
        let navigationViewController = UINavigationController(rootViewController: viewController)
        self.navigtionController = navigationViewController
        self.window?.rootViewController = navigationViewController
        self.window?.makeKeyAndVisible()
        self.window?.windowScene = windowScene
    }
    
    
    func getUser(){
        guard let userModel = Datamanager.shared.curentUser else { return }
        guard let url = URL(string: "https://valentinkilar.herokuapp.com/userGet?phone=\(String(userModel.phone))") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil else { return }
            
            guard let json = data?.jsonDictionary else { return  }
            DispatchQueue.main.async {
                if let name = json["Name"] as? String, name != userModel.name {
                    Datamanager.shared.updateProperty(of: userModel, value: name, for: #keyPath(UserModel.name))
                }
                
                if let name = json["Balance"] as? Float, name != Float(userModel.coins) {
                    Datamanager.shared.updateProperty(of: userModel, value: Int(name), for: #keyPath(UserModel.coins))
                }
                
                if let name = json["Position"] as? Int, name != userModel.placeInTop{
                    Datamanager.shared.updateProperty(of: userModel, value: Int(name), for: #keyPath(UserModel.placeInTop))
                }
                
                if let name = json["Insta"] as? String, name != userModel.instagram {
                    Datamanager.shared.updateProperty(of: userModel, value: name, for: #keyPath(UserModel.instagram))
                }
                
                if let name = json["VotedFor"] as? [String:Any], name.jsonData != userModel.votesData {
                    Datamanager.shared.updateProperty(of: userModel, value: name.jsonData, for: #keyPath(UserModel.votesData))
                }
                
                if let name = json["Likes"] as? Int, name != userModel.valentines {
                    Datamanager.shared.updateProperty(of: userModel, value: name, for: #keyPath(UserModel.valentines ))
                }
            }
        }
        task.resume()
        
        guard let urlImg = URL(string: "https://valentinkilar.herokuapp.com/photo?phone=\(String(userModel.phone))&get=1") else { return }
        let taskImage = URLSession.shared.dataTask(with: urlImg) {(data, response, error) in
            guard error == nil else { return }
            
            guard let json = data?.jsonDictionary,
                  let byteArray = json["Photo"] as? String,
                  let data = Data(base64Encoded: byteArray)  else { return }
            DispatchQueue.main.async {
                guard data != userModel.imageData else { return }
                Datamanager.shared.updateProperty(of: userModel, value: data, for: #keyPath(UserModel.imageData ))
            }
            
        }
        taskImage.resume()
        
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

