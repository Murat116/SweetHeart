//
//  MainVC.swift
//  Sweetheart
//
//  Created by anmin on 29.01.2021.
//

import UIKit

class MainVC: UIViewController{
    var tableView = UITableView()
    var balance = UIButton()
    var meBtn = UIButton()
    
    var userModel: UserModel = Datamanager.shared.curentUser
    
    var alluser: [UserModel] = Datamanager.shared.anotherUsers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.balance)
        self.balance.translatesAutoresizingMaskIntoConstraints = false
        self.balance.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        self.balance.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.balance.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.balance.widthAnchor.constraint(equalTo: self.balance.heightAnchor).isActive = true
        
        self.balance.addTarget(self, action: #selector(self.openBuy), for: .touchUpInside)
        
        self.view.addSubview(self.meBtn)
        self.meBtn.translatesAutoresizingMaskIntoConstraints = false
        self.meBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -15).isActive = true
        self.meBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        self.meBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.meBtn.widthAnchor.constraint(equalTo: self.meBtn.heightAnchor).isActive = true
        
        self.meBtn.addTarget(self, action: #selector(self.openMeView), for: .touchUpInside)
    }
    
    @objc func openMeView(){
        let vc = UserRegistaration()
        vc.configure(with: self.userModel, state: .view)
        self.present(vc, animated: true)
    }
    
    @objc func openBuy(){
        
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alluser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
