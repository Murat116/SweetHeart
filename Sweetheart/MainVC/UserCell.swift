//
//  UserCell.swift
//  Sweetheart
//
//  Created by anmin on 29.01.2021.
//

import UIKit

class UserCell: UITableViewCell{
    var number = UILabel()
    var avatar: UIImageView = UIImageView()
    var name =  UILabel()
    var instagram = UILabel()
    var likes = UILabel()
    var likeImage = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.selectionStyle = .none
        
        self.addSubview(self.avatar)
        self.avatar.translatesAutoresizingMaskIntoConstraints = false
        self.avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 38).isActive = true
        self.avatar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.avatar.widthAnchor.constraint(equalTo: self.avatar.heightAnchor).isActive = true
        
        self.avatar.contentMode = .scaleToFill
        self.avatar.layer.masksToBounds = false
        self.avatar.clipsToBounds = true
        
        self.addSubview(self.number)
        self.number.translatesAutoresizingMaskIntoConstraints = false
        self.number.rightAnchor.constraint(equalTo: self.avatar.leftAnchor, constant: -16).isActive = true
        self.number.topAnchor.constraint(equalTo: self.topAnchor, constant: 29).isActive = true
        self.number.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -29).isActive = true
        
        self.number.font = UIFont.systemFont(ofSize: 12)
        self.number.textAlignment = .right
        
        self.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.leftAnchor.constraint(equalTo: self.avatar.rightAnchor, constant: 16).isActive = true
        self.name.topAnchor.constraint(equalTo: self.avatar.topAnchor, constant: 16).isActive = true
        self.name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        
        self.name.font = UIFont.boldSystemFont(ofSize: 18)
        self.name.textColor = .black
        
        self.addSubview(self.instagram)
        self.instagram.translatesAutoresizingMaskIntoConstraints = false
        self.instagram.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 8).isActive = true
        self.instagram.leftAnchor.constraint(equalTo: self.name.leftAnchor).isActive = true
        self.instagram.rightAnchor.constraint(equalTo: self.name.rightAnchor, constant: 10).isActive = true
        
        self.instagram.font = .systemFont(ofSize: 12)
        self.instagram.textColor = UIColor(r: 135, g: 135, b: 135, a: 1)
        
        self.addSubview(self.likeImage)
        self.likeImage.translatesAutoresizingMaskIntoConstraints = false
        self.likeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.likeImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.likeImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        self.likeImage.widthAnchor.constraint(equalTo: self.likeImage.heightAnchor).isActive = true
        
        self.likeImage.image = UIImage(named: "Hearts")
        
        self.addSubview(self.likes)
        self.likes.translatesAutoresizingMaskIntoConstraints = false
        self.likes.rightAnchor.constraint(equalTo: self.likeImage.leftAnchor, constant: -5).isActive = true
        self.likes.centerYAnchor.constraint(equalTo: self.likeImage.centerYAnchor).isActive = true
        
        self.likes.font = UIFont.systemFont(ofSize: 12)
        self.likes.textColor = UIColor(r: 255, g: 95, b: 45, a: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: UserModel, number: Int){
        let image = model.imageData != nil ? UIImage(data: model.imageData!) : UIImage(named: "avatar")
        self.avatar.image = image
        self.number.text = String(number + 1)
        self.name.text = model.name ?? "User"
        self.instagram.text = model.instagram ?? "empty"
        self.likes.text = String(model.valentines)
        
        if model.id == Datamanager.shared.curentUser.id || number < 3{
            self.layer.cornerRadius = 11
            self.backgroundColor =  model.id == Datamanager.shared.curentUser.id ? UIColor(r: 255, g: 239, b: 234) : .white
            self.name.textColor = UIColor(r: 255, g: 95, b: 41)
            self.instagram.textColor = UIColor(r: 252, g: 154, b: 124)
        }else{
            self.backgroundColor = .white
            self.instagram.textColor = UIColor(r: 135, g: 135, b: 135, a: 1)
            self.name.textColor = .black
        }
        self.layoutIfNeeded()
        self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
    }
}

