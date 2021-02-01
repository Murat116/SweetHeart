//
//  UserSettings.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import UIKit

class UserRegistaration: UIViewController {
    var backBtn = UIButton()
    
    var avatarView = UIImageView()
    var name = UILabel()
    var insta = UILabel()
    
    var place = UIButton()
    var hearts = UIButton()
    
    var nameField = UITextField()
    var instField = UITextField()
    
    var editbtn = UIButton()
    
    var saveBtn = UIButton()
    var coppy = UIButton()
    var cancel = UIButton()
    
    var userModel: UserModel!
    
    var state: VCState = .edit {
        didSet{
            self.saveBtn.isHidden = self.state == .edit
            //            self.editBtn.isHidden = self.state != .edit
            self.nameField.allowsEditingTextAttributes = self.state != .edit
            self.instField.allowsEditingTextAttributes = self.state != .edit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.backBtn)
        self.backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        self.backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 38).isActive = true
        self.backBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.backBtn.widthAnchor.constraint(equalToConstant: 121).isActive = true
        
        self.backBtn.setImage(UIImage(named: "backBtn"), for: .normal)
        self.backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 23)
        
        self.backBtn.setTitle("Рейтинг", for: .normal)
        self.backBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.backBtn.setTitleColor(.black, for: .normal)
        self.backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        
        self.view.addSubview(self.avatarView)
        self.avatarView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.avatarView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 47).isActive = true
        self.avatarView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        self.avatarView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        self.avatarView.image = UIImage(named: "testPhoto")
        
        self.view.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.centerXAnchor.constraint(equalTo: self.avatarView.centerXAnchor).isActive = true
        self.name.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16).isActive = true
        self.name.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        self.name.textAlignment = .center
        self.name.text = "Саня"
        
        self.view.addSubview(self.insta)
        self.insta.translatesAutoresizingMaskIntoConstraints = false
        self.insta.topAnchor.constraint(equalTo: self.name.bottomAnchor).isActive = true
        self.insta.centerXAnchor.constraint(equalTo: self.name.centerXAnchor).isActive = true
        self.insta.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.insta.font = .systemFont(ofSize: 14)
        self.insta.textColor = UIColor(r: 114, g: 114, b: 114)
        self.insta.text = "@pepa_desh"
        
        self.view.addSubview(self.place)
        self.place.translatesAutoresizingMaskIntoConstraints = false
        self.place.topAnchor.constraint(equalTo: self.insta.bottomAnchor, constant: 16).isActive = true
        self.place.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.place.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.place.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.place.setImage(UIImage(named: "Star"), for: .normal)
        self.place.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        
        self.place.titleLabel?.font = .systemFont(ofSize: 14)
        self.place.setTitle("4 место", for: .normal)
        self.place.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        
        self.view.addSubview(self.hearts)
        self.hearts.translatesAutoresizingMaskIntoConstraints = false
        self.hearts.topAnchor.constraint(equalTo: self.place.bottomAnchor, constant: 4).isActive = true
        self.hearts.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.hearts.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.hearts.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.hearts.setImage(UIImage(named: "Hearts"), for: .normal)
        self.hearts.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        
        self.hearts.titleLabel?.font = .systemFont(ofSize: 14)
        self.hearts.setTitle("15", for: .normal)
        self.hearts.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        
        self.view.addSubview(self.nameField)
        self.nameField.translatesAutoresizingMaskIntoConstraints = false
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.nameField.topAnchor.constraint(equalTo: self.hearts.bottomAnchor, constant: 48).isActive = true
        self.nameField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        self.nameField.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.nameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
        self.nameField.setLeftPaddingPoints(24)
        self.nameField.layer.cornerRadius = 7
        
        self.view.addSubview(self.instField)
        self.instField.translatesAutoresizingMaskIntoConstraints = false
        self.instField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.instField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.instField.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: 16).isActive = true
        self.instField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        self.instField.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.instField.attributedPlaceholder = NSAttributedString(string: "Instagram", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
        self.instField.setLeftPaddingPoints(24)
        self.instField.layer.cornerRadius = 7
        
        
        self.view.addSubview(self.editbtn)
        self.editbtn.translatesAutoresizingMaskIntoConstraints = false
        self.editbtn.topAnchor.constraint(equalTo: self.instField.bottomAnchor, constant: 24).isActive = true
        self.editbtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.editbtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.editbtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        self.editbtn.backgroundColor = UIColor(r: 255, g: 95, b: 45)
        self.editbtn.titleLabel?.font = .systemFont(ofSize: 16)
        self.editbtn.setTitle("Изменить данные", for: .normal)
        self.editbtn.layer.cornerRadius = 7
        
        self.editbtn.addTarget(self, action: #selector(self.edit(btn:)), for: .touchUpInside)
        
        self.view.addSubview(self.saveBtn)
        self.saveBtn.translatesAutoresizingMaskIntoConstraints = false
        self.saveBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.saveBtn.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -4).isActive = true
        self.saveBtn.topAnchor.constraint(equalTo: self.instField.bottomAnchor, constant: 24).isActive = true
        self.saveBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.saveBtn.backgroundColor = UIColor(r: 255, g: 95, b: 45)
        self.saveBtn.titleLabel?.font = .systemFont(ofSize: 16)
        self.saveBtn.setTitle("Сохранить", for: .normal)
        self.saveBtn.layer.cornerRadius = 8
        self.saveBtn.isHidden = true
        
        self.saveBtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
        
        self.view.addSubview(self.cancel)
        self.cancel.translatesAutoresizingMaskIntoConstraints = false
        self.cancel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.cancel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 4).isActive = true
        self.cancel.topAnchor.constraint(equalTo: self.instField.bottomAnchor, constant: 24).isActive = true
        self.cancel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.cancel.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.cancel.titleLabel?.font = .systemFont(ofSize: 16)
        self.cancel.setTitle("Отмена", for: .normal)
        self.cancel.layer.cornerRadius = 8
        self.cancel.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        
        self.cancel.addTarget(self, action: #selector(self.edit(btn:)), for: .touchUpInside)
        self.cancel.isHidden = true
        
        self.view.addSubview(self.coppy)
        self.coppy.translatesAutoresizingMaskIntoConstraints = false
        self.coppy.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        self.coppy.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.coppy.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.coppy.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        self.coppy.layer.cornerRadius = 8
        self.coppy.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.coppy.setTitle("Скопировать ID", for: .normal)
        self.coppy.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.coppy.setImage(UIImage(named: "Coppy"), for: .normal)
        self.coppy.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        
    }
    
    func configure(with model: UserModel, state: VCState){
        self.userModel = model
        if state == .edit{
            self.nameField.text = model.name
            self.instField.text = model.instagram
            
            
            
        }else{
            
        }
    }
    
    @objc func edit(btn: UIButton){
        UIView.animate(withDuration: 0.2) {
            self.saveBtn.isHidden = btn != self.editbtn
            self.cancel.isHidden = btn != self.editbtn
            self.editbtn.isHidden = btn == self.editbtn
        }
    }
    
    @objc func save(){
        self.userModel.name = self.nameField.text
        self.userModel.instagram = self.instField.text
        self.userModel.imageData = self.avatarView.image?.pngData()
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

enum VCState{
    case view
    case edit
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
