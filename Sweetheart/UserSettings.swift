//
//  UserSettings.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import UIKit

class UserRegistaration: UIViewController {
    var editBtn = UIButton()
    
    var nameField = UITextField()
    var instField = UITextField()
    
   var avatarView = AvatarView()
    
    var buyHeartsView = UIButton()
    
    var saveBtn = UIButton()
    
    var userModel: UserModel!
    
    var state: VCState = .edit {
        didSet{
            self.saveBtn.isHidden = self.state == .edit
            self.editBtn.isHidden = self.state != .edit
            self.nameField.allowsEditingTextAttributes = self.state != .edit
            self.instField.allowsEditingTextAttributes = self.state != .edit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.editBtn)
        self.editBtn.translatesAutoresizingMaskIntoConstraints = false
        self.editBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.editBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 30).isActive = true
        self.editBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.editBtn.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        self.editBtn.setTitle("Edit", for: .normal)
        self.editBtn.addTarget(self, action: #selector(self.edit), for: .touchUpInside)
        
        self.view.addSubview(self.buyHeartsView)
        self.buyHeartsView.translatesAutoresizingMaskIntoConstraints = false
        self.buyHeartsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.buyHeartsView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 30).isActive = true
        self.buyHeartsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buyHeartsView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        self.buyHeartsView.setTitle("15", for: .normal)
        self.buyHeartsView.addTarget(self, action: #selector(self.edit), for: .touchUpInside)
        
        self.view.addSubview(self.avatarView)
        self.avatarView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.avatarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        self.avatarView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.avatarView.widthAnchor.constraint(equalToConstant: 115).isActive = true
        
        self.view.addSubview(self.nameField)
        self.nameField.translatesAutoresizingMaskIntoConstraints = false
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.nameField.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 33).isActive = true
        self.nameField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.view.addSubview(self.instField)
        self.instField.translatesAutoresizingMaskIntoConstraints = false
        self.instField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.instField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.instField.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: 33).isActive = true
        self.instField.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.view.addSubview(self.saveBtn)
        self.saveBtn.translatesAutoresizingMaskIntoConstraints = false
        self.saveBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.saveBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.saveBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -33).isActive = true
        self.saveBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    func configure(with model: UserModel, state: VCState){
        self.userModel = model
        if state == .edit{
            self.nameField.text = model.name
            self.instField.text = model.instagram
            self.avatarView.configure(photoData: model.imageData, hearts: model.valentines)
            
            self.buyHeartsView.setTitle(String(model.coins), for: .normal)
        }else{
            self.buyHeartsView.isHidden = true
        }
    }
    
    @objc func edit(){
        self.state = .edit
    }
    
    @objc func save(){
        self.userModel.name = self.nameField.text
        self.userModel.instagram = self.instField.text
        self.userModel.imageData = self.avatarView.photoImageView.image?.pngData()
    }
}

enum VCState{
    case view
    case edit
}
