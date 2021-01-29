//
//  AvatarView.swift
//  Sweetheart
//
//  Created by anmin on 29.01.2021.
//

import UIKit

class AvatarView: UIView{
    var photoImageView = UIImageView()
    var heartsView = HeartsView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.photoImageView)
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.photoImageView.heightAnchor.constraint(equalTo: self.photoImageView.widthAnchor).isActive = true
        
        self.addSubview(self.heartsView)
        self.heartsView.translatesAutoresizingMaskIntoConstraints = false
        self.heartsView.centerYAnchor.constraint(equalTo: self.photoImageView.bottomAnchor).isActive = true
        self.heartsView.centerXAnchor.constraint(equalTo: self.photoImageView.centerXAnchor).isActive = true
        self.heartsView.heightAnchor.constraint(equalTo: self.photoImageView.heightAnchor, multiplier: 0.3).isActive = true
        self.heartsView.widthAnchor.constraint(equalTo: self.heartsView.heightAnchor).isActive = true
    }
    
    func configure(photoData: Data?, hearts: Int){
        let image = photoData != nil ?  UIImage(data: photoData!) : UIImage(named: "Avatar")
        self.photoImageView.image = image
        self.heartsView.configure(herts: hearts)
        
        self.layoutIfNeeded()
        
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.height / 2
        self.heartsView.layer.cornerRadius = self.heartsView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HeartsView: UIView{
    var label = UILabel()
    var heartImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -2).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.label.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.label.leftAnchor.constraint(equalTo: self.label.leftAnchor, constant: 2).isActive = true
        
        self.addSubview(self.heartImage)
        self.heartImage.translatesAutoresizingMaskIntoConstraints = false
        self.heartImage.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 2).isActive = true
        self.heartImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant:  -2).isActive = true
        self.heartImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.heartImage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(herts: Int){
        self.label.text = String(herts)
    }
}
