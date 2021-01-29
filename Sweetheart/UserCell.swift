//
//  UserCell.swift
//  Sweetheart
//
//  Created by anmin on 29.01.2021.
//

import UIKit

class UserCell: UITableViewCell{
    var avatar: AvatarView = AvatarView()
    var name =  UILabel()
    var instagram = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.avatar)
        self.avatar.translatesAutoresizingMaskIntoConstraints = false
        self.avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.avatar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.avatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.avatar.widthAnchor.constraint(equalTo: self.avatar.heightAnchor).isActive = true
        
        self.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.leftAnchor.constraint(equalTo: self.avatar.rightAnchor, constant: 10).isActive = true
        self.name.topAnchor.constraint(equalTo: self.avatar.topAnchor).isActive = true
        self.name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        self.addSubview(self.instagram)
        self.instagram.translatesAutoresizingMaskIntoConstraints = false
        self.instagram.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10).isActive = true
        self.instagram.leftAnchor.constraint(equalTo: self.name.leftAnchor).isActive = true
        self.instagram.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: UserModel){
        self.avatar.configure(photoData: model.imageData, hearts: model.valentines)
        self.name.text = model.name
        self.instagram.text = model.name
    }
}

