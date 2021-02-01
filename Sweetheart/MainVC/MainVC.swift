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
    
    var userModel: UserModel = Datamanager.shared.curentUser
    
    var alluser: [UserModel] = Datamanager.shared.anotherUsers
    
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
        let image = self.userModel.imageData != nil ? UIImage(data: self.userModel.imageData!) : UIImage(named: "testPhoto")
        self.meBtn.setImage(image, for: .normal)
        
        self.view.addSubview(self.balance)
        self.balance.translatesAutoresizingMaskIntoConstraints = false
        self.balance.centerYAnchor.constraint(equalTo: self.myName.centerYAnchor).isActive = true
        self.balance.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.balance.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.balance.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.balance.contentHorizontalAlignment = .left
        
        self.balance.semanticContentAttribute = .forceRightToLeft
        self.balance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        self.balance.setImage(UIImage(named: "Hearts"), for: .normal)
        
        self.balance.setTitle("1", for: .normal)
        self.balance.setTitleColor(UIColor(r: 255, g: 95, b: 41), for: .normal)
        self.balance.addTarget(self, action: #selector(self.openBuy), for: .touchUpInside)
        
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
    }
    
    @objc func openMeView(){
        let vc = UserRegistaration()
        vc.configure(with: self.userModel, state: .view)
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell()}
        cell.configure(with: self.userModel, number: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}
