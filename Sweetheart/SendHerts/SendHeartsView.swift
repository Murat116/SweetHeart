//
//  SendHeartsView.swift
//  Sweetheart
//
//  Created by anmin on 30.01.2021.
//

import UIKit

class SendHertsVC: UIViewController{
    
    var user: UserModel? = nil
    
    var backBtn = UIButton()
    var balance = UIButton()
    
    var avatarView = UIImageView()
    var avatarTop : NSLayoutConstraint? = nil
    var needApp: Bool = false
    
    var name = UILabel()
    var insta = UILabel()
    
    var sendTypeLabel = UILabel()
    var idTypeBtn = UIButton()
    var phomeTypeBtn = UIButton()
    
    var pastBtn = UIButton()
    var textField = UITextField()
    
    var plusBtn = UIButton()
    var minusBtn = UIButton()
    
    var maxHerts: Int = 10
    
    var countLabel = UILabel()
    var countHerts: Int = 1 {
        didSet{
            guard self.countHerts != 0 && self.countHerts <= self.maxHerts else { self.countHerts = oldValue; return }
            self.countLabel.text = String(self.countHerts)
            self.sendBtn.setTitle("Отправить \(self.countHerts)", for: .normal)
            if self.countHerts == 1 {
                self.minusBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
            }
            
            self.minusBtn.backgroundColor = self.countHerts == 1 ? UIColor(r: 247, g: 247, b: 247) :  UIColor(r: 255, g: 239, b: 234)
            self.plusBtn.backgroundColor = self.countHerts == self.maxHerts ? UIColor(r: 247, g: 247, b: 247) : UIColor(r: 255, g: 239, b: 234)
            
        }
    }
    
    var sendBtn = UIButton()
    
    
    var textFieldType: FiledType = .none {
        didSet{
            if self.textFieldType == .id {
                self.textField.isHidden = false
                self.pastBtn.isHidden = false
                self.phomeTypeBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
                self.phomeTypeBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
                self.pastBtn.setImage(UIImage(named: "Paste"), for: .normal)
                self.textField.attributedPlaceholder = NSAttributedString(string: "ID пользователя", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
                self.idTypeBtn.backgroundColor = UIColor(r: 255, g: 219, b: 208)
                self.idTypeBtn.setTitleColor(UIColor(r: 222, g: 65, b: 16), for: .normal)
            }else{
                self.textField.isHidden = false
                self.pastBtn.isHidden = false
                self.idTypeBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
                self.idTypeBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
                self.pastBtn.setImage(UIImage(named: "defaultPhoto"), for: .normal)
                self.textField.attributedPlaceholder = NSAttributedString(string: "Номер пользователя", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
                self.phomeTypeBtn.backgroundColor = UIColor(r: 255, g: 219, b: 208)
                self.phomeTypeBtn.setTitleColor(UIColor(r: 222, g: 65, b: 16), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.avatarTop = self.avatarView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 47)
        self.avatarTop?.isActive = true
        self.avatarView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        self.avatarView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        self.avatarView.backgroundColor = UIColor(r: 255, g: 248, b: 234)
        self.avatarView.image = UIImage(named: "avatar")
        
        self.view.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.centerXAnchor.constraint(equalTo: self.avatarView.centerXAnchor).isActive = true
        self.name.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16).isActive = true
        //        self.name.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        self.name.textAlignment = .center
        self.name.isHidden = true
        
        self.view.addSubview(self.insta)
        self.insta.translatesAutoresizingMaskIntoConstraints = false
        self.insta.topAnchor.constraint(equalTo: self.name.bottomAnchor).isActive = true
        self.insta.centerXAnchor.constraint(equalTo: self.name.centerXAnchor).isActive = true
        self.insta.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.insta.font = .systemFont(ofSize: 14)
        self.insta.textColor = UIColor(r: 114, g: 114, b: 114)
        self.insta.isHidden = true
        
        
        self.view.addSubview(self.balance)
        self.balance.translatesAutoresizingMaskIntoConstraints = false
        self.balance.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true
        self.balance.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.balance.heightAnchor.constraint(equalToConstant: 28).isActive = true
        self.balance.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.balance.contentHorizontalAlignment = .right
        self.balance.semanticContentAttribute = .forceRightToLeft
        self.balance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        self.balance.setImage(UIImage(named: "Hearts"), for: .normal)
        
        self.balance.setTitle("1", for: .normal)
        self.balance.setTitleColor(UIColor(r: 255, g: 95, b: 41), for: .normal)
        //        self.balance.addTarget(self, action: #selector(self.openBuy), for: .touchUpInside)
        
        self.view.addSubview(self.sendTypeLabel)
        self.sendTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sendTypeLabel.topAnchor.constraint(equalTo: self.insta.bottomAnchor, constant: 32).isActive = true
        self.sendTypeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        
        self.sendTypeLabel.font = .boldSystemFont(ofSize: 20)
        self.sendTypeLabel.textColor = .black
        self.sendTypeLabel.text = "Способ отправки"
        
        self.view.addSubview(self.idTypeBtn)
        self.idTypeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.idTypeBtn.topAnchor.constraint(equalTo: self.sendTypeLabel.bottomAnchor, constant: 16).isActive = true
        self.idTypeBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.idTypeBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.idTypeBtn.heightAnchor.constraint(equalTo: self.idTypeBtn.widthAnchor, multiplier: 0.16).isActive = true
        
        self.idTypeBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.idTypeBtn.setTitle("Отправить по ID", for: .normal)
        self.idTypeBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.idTypeBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.idTypeBtn.layer.cornerRadius = 8
        
        self.idTypeBtn.addTarget(self, action: #selector(self.changeType), for: .touchUpInside)
        
        self.view.addSubview(self.phomeTypeBtn)
        self.phomeTypeBtn.translatesAutoresizingMaskIntoConstraints = false
        self.phomeTypeBtn.topAnchor.constraint(equalTo: self.idTypeBtn.bottomAnchor, constant: 8).isActive = true
        self.phomeTypeBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.phomeTypeBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.phomeTypeBtn.heightAnchor.constraint(equalTo: self.phomeTypeBtn.widthAnchor, multiplier: 0.16).isActive = true
        
        self.phomeTypeBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.phomeTypeBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.phomeTypeBtn.setTitle("Отправить по телефону", for: .normal)
        self.phomeTypeBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.phomeTypeBtn.layer.cornerRadius = 8
        
        self.phomeTypeBtn.addTarget(self, action: #selector(self.changeType), for: .touchUpInside)
        
        self.view.addSubview(self.pastBtn)
        self.pastBtn.translatesAutoresizingMaskIntoConstraints = false
        self.pastBtn.topAnchor.constraint(equalTo: self.phomeTypeBtn.bottomAnchor, constant: 32).isActive = true
        self.pastBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.pastBtn.heightAnchor.constraint(equalTo: self.phomeTypeBtn.heightAnchor).isActive = true
        self.pastBtn.widthAnchor.constraint(equalTo: self.pastBtn.heightAnchor).isActive = true
        
        self.pastBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.pastBtn.layer.cornerRadius = 8
        self.pastBtn.isHidden = true
        self.pastBtn.addTarget(self, action: #selector(self.past), for: .touchUpInside)
        
        self.view.addSubview(self.textField)
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.topAnchor.constraint(equalTo: self.phomeTypeBtn.bottomAnchor, constant: 32).isActive = true
        self.textField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.textField.rightAnchor.constraint(equalTo: self.pastBtn.leftAnchor, constant: -8).isActive = true
        self.textField.heightAnchor.constraint(equalTo: self.phomeTypeBtn.heightAnchor).isActive = true
        
        self.textField.setLeftPaddingPoints(24)
        self.textField.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.textField.layer.cornerRadius = 7
        self.textField.isHidden = true
        
        self.textField.delegate = self
        
        self.view.addSubview(self.sendBtn)
        self.sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sendBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        self.sendBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.sendBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.sendBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        self.sendBtn.layer.cornerRadius = 8
        self.sendBtn.semanticContentAttribute = .forceRightToLeft
        self.sendBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.sendBtn.setTitle("Отправить 1", for: .normal)
        self.sendBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.sendBtn.setImage(UIImage(named: "Hearts")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.sendBtn.tintColor = UIColor(r: 185, g: 185, b: 185)
        self.sendBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        
        
        self.view.addSubview(self.countLabel)
        self.countLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countLabel.bottomAnchor.constraint(equalTo: self.sendBtn.topAnchor, constant: -36).isActive = true
        self.countLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.countLabel.font = .boldSystemFont(ofSize: 24)
        
        self.countLabel.textColor = UIColor(r: 185, g: 185, b: 185)
        self.countLabel.text = "1"
        
        
        self.view.addSubview(self.minusBtn)
        self.minusBtn.translatesAutoresizingMaskIntoConstraints = false
        self.minusBtn.centerYAnchor.constraint(equalTo: self.countLabel.centerYAnchor).isActive = true
        self.minusBtn.rightAnchor.constraint(equalTo: self.countLabel.leftAnchor, constant: -32).isActive = true
        self.minusBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.minusBtn.widthAnchor.constraint(equalTo: self.minusBtn.heightAnchor).isActive = true
        
        self.minusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.minusBtn.setTitle("-", for: .normal)
        self.minusBtn.titleLabel?.font = .systemFont(ofSize: 24)
        self.minusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.minusBtn.layer.cornerRadius = 5
        
        self.minusBtn.addTarget(self, action: #selector(self.changeCount(sender:)), for: .touchUpInside)
        
        self.view.addSubview(self.plusBtn)
        self.plusBtn.translatesAutoresizingMaskIntoConstraints = false
        self.plusBtn.centerYAnchor.constraint(equalTo: self.countLabel.centerYAnchor).isActive = true
        self.plusBtn.leftAnchor.constraint(equalTo: self.countLabel.rightAnchor, constant: 32).isActive = true
        self.plusBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.plusBtn.widthAnchor.constraint(equalTo: self.minusBtn.heightAnchor).isActive = true
        
        self.plusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.plusBtn.setTitle("+", for: .normal)
        self.plusBtn.titleLabel?.font = .systemFont(ofSize: 24)
        self.plusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.plusBtn.layer.cornerRadius = 5
        
        self.plusBtn.addTarget(self, action: #selector(self.changeCount(sender:)), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
        self.avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
        
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGest)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
        guard self.textField.frame.maxY + keyboardHeight > self.view.frame.height else { return }
        self.avatarTop?.constant -= 60
        self.needApp = true
    }
    
    @objc func hideKeyboard(){
        self.textField.resignFirstResponder()
        guard self.needApp else { return }
        self.needApp = false
        self.avatarTop?.constant += 60
    }
    
    @objc func changeCount(sender: UIButton){
        guard self.textFieldType != .none else { return }
        self.countHerts += sender == self.minusBtn ? -1 : 1
    }
    
    @objc func changeType(sender: UIButton){
        self.textField.text?.removeAll()
        
        self.countLabel.textColor = UIColor(r: 255, g: 95, b: 45)
        self.minusBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.plusBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        
        self.sendBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.sendBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.sendBtn.tintColor = UIColor(r: 255, g: 95, b: 45)
        
        if sender == self.idTypeBtn {
            self.textFieldType = .id
        }else{
            self.textFieldType = .phone
        }
    }
    
    @objc func past(){
        if self.textFieldType == .id{
            self.textField.text = UIPasteboard.general.string
            guard let text = UIPasteboard.general.string else { return }
            self.getUser(value: text)
        }else{
            let vc = FriendsViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getUser(value: String){
        //send user -> get user
        self.name.text = "Саня"
        self.insta.text = "@pepa_desh"
        self.avatarView.image = UIImage(named: "testPhoto")
    }
    
}

import Contacts
extension SendHertsVC: Conactdelegate{
    func getConact(conact: CNContact) {
        for num in conact.phoneNumbers {
            let numVal = num.value
            if num.label == CNLabelPhoneNumberMobile {
                self.textField.text = numVal.stringValue
                self.getUser(value: numVal.stringValue)
                break
            }
        }
        guard (self.textField.text?.isEmpty ?? true) else { return }
        let alert = UIAlertController(title: "Не получается извлечь номер", message: "Попробуйте позже или введите номер вручную", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension SendHertsVC: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard textField.text?.count == 36, let text = textField.text else { return true}
        self.getUser(value: text)
        return true
    }
}

enum FiledType{
    case none
    case id
    case phone
}
