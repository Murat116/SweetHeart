//
//  MainVC.swift
//  Sweetheart
//
//  Created by anmin on 29.01.2021.
//

import UIKit

class MainVC: UIViewController{
    
    var tableView = UITableView()
    var topLabel = UILabel()
    
    var balance = UIButton()
    var meBtn = UIButton()
    var myName = UILabel()
    
    var sendBtn = UIButton()
    
    var userModel: UserModel { get {Datamanager.shared.curentUser! } }
    
    var alluser: [UserModel]  {
        get{ Datamanager.shared.anotherUsers }
    }
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.myName)
        self.myName.translatesAutoresizingMaskIntoConstraints = false
        self.myName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.myName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        self.myName.textColor = .black
        self.myName.font = .boldSystemFont(ofSize: 20)
        self.myName.text = self.userModel.name ?? "User"
        
        self.view.addSubview(self.meBtn)
        self.meBtn.translatesAutoresizingMaskIntoConstraints = false
        self.meBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -32).isActive = true
        self.meBtn.centerYAnchor.constraint(equalTo: self.myName.centerYAnchor).isActive = true
        self.meBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.meBtn.widthAnchor.constraint(equalTo: self.meBtn.heightAnchor).isActive = true
        
        self.meBtn.addTarget(self, action: #selector(self.openMeView), for: .touchUpInside)
        let image = self.userModel.imageData != nil && !(self.userModel.imageData?.isEmpty ?? true) ? UIImage(data: self.userModel.imageData!) : UIImage(named: "avatar")
        self.meBtn.setImage(image, for: .normal)
    
        self.meBtn.contentEdgeInsets = .zero
        self.meBtn.imageView?.contentMode = .scaleAspectFit
        self.meBtn.layer.masksToBounds = true
        
        self.meBtn.imageView!.bounds = self.meBtn.imageView!.frame
        self.meBtn.imageView!.layer.cornerRadius = self.meBtn.imageView!.frame.size.width / 2
        
        self.view.addSubview(self.balance)
        self.balance.translatesAutoresizingMaskIntoConstraints = false
        self.balance.centerYAnchor.constraint(equalTo: self.myName.centerYAnchor).isActive = true
        self.balance.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
//        self.balance.heightAnchor.constraint(equalToConstant: 28).isActive = true
//        self.balance.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.balance.contentHorizontalAlignment = .left
        
        self.balance.semanticContentAttribute = .forceRightToLeft
        self.balance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        self.balance.setImage(UIImage(named: "Hearts"), for: .normal)
        
        self.balance.setTitle("\(self.userModel.coins)", for: .normal)
        self.balance.setTitleColor(UIColor(r: 255, g: 95, b: 41), for: .normal)
        self.balance.addTarget(self, action: #selector(self.openBuy), for: .touchUpInside)
        self.balance.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        let plusLabel = UILabel()
        self.view.addSubview(plusLabel)
        plusLabel.translatesAutoresizingMaskIntoConstraints = false
        plusLabel.centerYAnchor.constraint(equalTo: self.balance.centerYAnchor, constant: -2).isActive = true
        plusLabel.leftAnchor.constraint(equalTo: self.balance.rightAnchor, constant: 3).isActive = true
        
        plusLabel.text = "+"
        plusLabel.textColor = UIColor(r: 255, g: 95, b: 41)
        plusLabel.font = .boldSystemFont(ofSize: 22)
        
        self.view.addSubview(self.topLabel)
        self.topLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.topLabel.topAnchor.constraint(equalTo: self.myName.bottomAnchor, constant: 44).isActive = true
        
        self.topLabel.textColor = .black
        self.topLabel.font = .boldSystemFont(ofSize: 24)
        self.topLabel.text = "Топ 100"
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 21).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        self.tableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.sendBtn)
        self.sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sendBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -36).isActive = true
        self.sendBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 93).isActive = true
        self.sendBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -93).isActive = true
        self.sendBtn.heightAnchor.constraint(equalTo: self.sendBtn.widthAnchor, multiplier: 0.3).isActive = true
        
        self.sendBtn.backgroundColor = UIColor(r: 255, g: 95, b: 41)
        self.sendBtn.layer.cornerRadius = 10
        self.sendBtn.semanticContentAttribute = .forceRightToLeft
        
        self.sendBtn.setTitle("Отправить", for: .normal)
        self.sendBtn.setTitleColor(UIColor(r: 255, g: 248, b: 235), for: .normal)
        
        self.sendBtn.setImage(UIImage(named: "Hearts")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.sendBtn.imageView?.tintColor = UIColor(r: 255, g: 248, b: 235)
        self.sendBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)

        self.sendBtn.addTarget(self, action: #selector(self.sendMsg), for: .touchUpInside)

        self.view.layoutIfNeeded()
        self.meBtn.layer.cornerRadius = self.meBtn.frame.height / 2
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.balance.setTitle(String(self.userModel.coins), for: .normal)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        
        guard let userModel = Datamanager.shared.curentUser else { return }
        guard let urluser = URL(string: "https://valentinkilar.herokuapp.com/userGet?phone=\(String(userModel.phone))") else { return }

        let taskUser = URLSession.shared.dataTask(with: urluser) {(data, response, error) in
            guard error == nil else { return }
            
            guard let json = data?.jsonDictionary else { return  }
            DispatchQueue.main.async {
            if let name = json["Name"] as? String, name != userModel.name {
                    Datamanager.shared.updateProperty(of: userModel, value: name, for: #keyPath(UserModel.name))
                }
                
                if let name = json["Balance"] as? Float, name != Float(userModel.coins) {
                    Datamanager.shared.updateProperty(of: userModel, value: Int(name), for: #keyPath(UserModel.coins))
                    self.balance.setTitle(String(name), for: .normal)
                }
            
                if let name = json["Likes"] as? Int, name != userModel.valentines {
                    Datamanager.shared.updateProperty(of: userModel, value: name, for: #keyPath(UserModel.valentines ))
                }
                
                if let name = json["Position"] as? Int, name != userModel.placeInTop{
                    Datamanager.shared.updateProperty(of: userModel, value: Int(name), for: #keyPath(UserModel.placeInTop))
                }
                
            }
        }
        taskUser.resume()

        guard let url = URL(string: "https://valentinkilar.herokuapp.com/userGet?all=1") else {
            let alert = UIAlertController(title: "Неправильный код", message: "error in code send", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(dataAttay, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self.present(alert, animated: true)
                }
                return
            }
            guard let data = dataAttay, let dict: [[String: Any]] = data.elements() else { return }
            DispatchQueue.main.async {
                for user in self.alluser where user.type != .curent {
                    do{
                        try Datamanager.shared.realm?.write{
                            Datamanager.shared.realm?.delete(user)
                        }
                    }catch{
                        print(error)
                    }
                }
    
                for value in dict{
                    guard let phone = value["Phone"] as? Int, let like = value["Likes"] as? Int else { continue }
                    let user = UserModel.createUser(phone: String(phone), type: .another)
                    user.valentines = like
                    
                    if  let val = value["Insta"] as? String{
                        user.instagram = val
                    }
                    
                    do{
                        try Datamanager.shared.realm?.write{
                            Datamanager.shared.realm?.add(user)
                        }
                    }catch{
                        print(error)
                    }
                    guard let urlImg = URL(string: "https://valentinkilar.herokuapp.com/photoGet?phone=\(String(user.phone))") else { return }
                    let taskImage = URLSession.shared.dataTask(with: urlImg) {(data, response, error) in
                        guard error == nil else {
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ок", style: .default))
                                self.present(alert, animated: true)
                            }
                            return
                        }
                        
                        guard let json = data?.jsonDictionary,
                              let byteArray = json["Photo"] as? String,
                              let data = Data(base64Encoded: byteArray)  else { return }
                        
                        
                        DispatchQueue.main.async {
                            Datamanager.shared.updateProperty(of: user, value: data, for: #keyPath(UserModel.imageData))
                            let index = self.alluser.firstIndex{$0.id == user.id}
                            self.tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: .automatic)
                        }
                    }
                    
                    taskImage.resume()
                    
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }

        task.resume()
    }
    
    @objc func openMeView(){
        let vc = UserRegistaration()
        vc.configure(state: .view)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openBuy(){
        let vc = BuyVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sendMsg(){
        let vc = SendHertsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alluser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell()}
        cell.configure(with: self.alluser[indexPath.row], number: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SendHertsVC()
        vc.changeType(sender: UIButton())
        vc.anotherUser = self.alluser[indexPath.row]
        vc.textFieldType = .name
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension Data {
    func elements () -> [[String:Any]]? {
        return try! JSONSerialization.jsonObject(with: self, options: []) as? [[String: Any]]
    }
}
