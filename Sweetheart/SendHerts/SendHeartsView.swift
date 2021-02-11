//
//  SendHeartsView.swift
//  Sweetheart
//
//  Created by anmin on 30.01.2021.
//

import UIKit
import PhoneNumberKit

class SendHertsVC: LoaderVC{
    
    var curentUser: UserModel {
        get {
            Datamanager.shared.curentUser!
        }
    }
    var anotherUser: UserModel? = nil
    
    
    
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
    
    var height: CGFloat = 0
    
    var plusBtn = UIButton()
    var minusBtn = UIButton()
    
    var maxHerts: Int {
        get{
            return Datamanager.shared.curentUser!.coins
        }
    }
    var isFree: Bool {
        get{
            guard let anotherUser = self.anotherUser else { return true}
            guard let votes = (self.curentUser.votesData?.jsonDictionary ?? [:])[anotherUser.phone] as? Int else { return true}
            return votes < 1
        }
    }
    
    var countLabel = UILabel()
    var countHerts: Int = -1 {
        didSet{
            guard self.countHerts != oldValue else { return }
            if self.countHerts <= 0 {
                self.countHerts = 0
                self.isRuning = false
                self.timer?.invalidate()
            }
            if self.countHerts > self.maxHerts + (self.isFree ? 1 : 0) {
                self.countHerts = self.maxHerts + (self.isFree ? 1 : 0)
                self.isRuning = false
                self.timer?.invalidate()
            }
            self.checkColors(oldValue: oldValue)
        }
    }
    
    var sendBtn = UIButton()
    
    
    var textFieldType: FiledType = .none {
        didSet{
            if self.textFieldType != oldValue, oldValue == .name{
                self.textField.isUserInteractionEnabled = true
            }
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
            self.avatarView.image = UIImage(named: "avatar")
            self.insta.isHidden = true
            self.name.isHidden = true
            
            if self.textFieldType == .name, let user = self.anotherUser
            {
                self.textField.text = user.name
                let image = user.imageData != nil && !(user.imageData?.isEmpty ?? true) ? UIImage(data: user.imageData!) : UIImage(named: "avatar")
                self.avatarView.image = image
                self.name.text = user.name
                self.insta.text = user.instagram
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
        
        self.view.addSubview(self.balance)
        self.balance.translatesAutoresizingMaskIntoConstraints = false
        self.balance.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true
        self.balance.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.balance.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        self.balance.contentHorizontalAlignment = .right
        self.balance.semanticContentAttribute = .forceRightToLeft
        self.balance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -3)
        self.balance.setImage(UIImage(named: "Hearts"), for: .normal)
        
        self.balance.setTitle(String(self.maxHerts), for: .normal)
        self.balance.setTitleColor(UIColor(r: 255, g: 95, b: 41), for: .normal)
        //        self.balance.addTarget(self, action: #selector(self.openBuy), for: .touchUpInside)
        
        self.view.addSubview(self.avatarView)
        self.avatarView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.avatarTop = self.avatarView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: ScreenTheme.isXFormat ? 47 : 10)
        self.avatarTop?.isActive = true
        self.avatarView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        self.avatarView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        self.avatarView.backgroundColor = UIColor(r: 255, g: 248, b: 234)
        self.avatarView.image = UIImage(named: "avatar")
        
        self.avatarView.contentMode = .scaleToFill
        self.avatarView.layer.masksToBounds = false
        self.avatarView.clipsToBounds = true
        
        self.view.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.centerXAnchor.constraint(equalTo: self.avatarView.centerXAnchor).isActive = true
        self.name.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16).isActive = true
        //        self.name.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        self.name.textAlignment = .center
        self.name.isHidden = self.textFieldType != .name
        
        self.view.addSubview(self.insta)
        self.insta.translatesAutoresizingMaskIntoConstraints = false
        self.insta.topAnchor.constraint(equalTo: self.name.bottomAnchor).isActive = true
        self.insta.centerXAnchor.constraint(equalTo: self.name.centerXAnchor).isActive = true
        self.insta.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.insta.font = .systemFont(ofSize: 14)
        self.insta.textColor = UIColor(r: 114, g: 114, b: 114)
        self.insta.isHidden = self.textFieldType != .name
        
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
        self.pastBtn.isHidden = self.textFieldType != .name
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
        self.textField.isHidden = self.textFieldType != .name
        
        self.textField.delegate = self
        
        self.view.addSubview(self.sendBtn)
        self.sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sendBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32).isActive = true
        self.sendBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.sendBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.sendBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        self.sendBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.sendBtn.layer.cornerRadius = 8
        self.sendBtn.semanticContentAttribute = .forceRightToLeft
        self.sendBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.sendBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.sendBtn.setTitle("Отправить", for: .normal)
        self.sendBtn.setImage(UIImage(named: "Hearts")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.sendBtn.tintColor = UIColor(r: 185, g: 185, b: 185)
        self.sendBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        
        self.sendBtn.addTarget(self, action: #selector(self.sendSms), for: .touchUpInside)
        
        self.view.addSubview(self.countLabel)
        self.countLabel.translatesAutoresizingMaskIntoConstraints = false
        self.countLabel.bottomAnchor.constraint(equalTo: self.sendBtn.topAnchor, constant: -36).isActive = true
        self.countLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.countLabel.font = .boldSystemFont(ofSize: 24)
        self.countLabel.text = "0"
        self.countLabel.textColor = UIColor(r: 185, g: 185, b: 185)
        
        self.view.addSubview(self.minusBtn)
        self.minusBtn.translatesAutoresizingMaskIntoConstraints = false
        self.minusBtn.centerYAnchor.constraint(equalTo: self.countLabel.centerYAnchor).isActive = true
        self.minusBtn.rightAnchor.constraint(equalTo: self.countLabel.leftAnchor, constant: -32).isActive = true
        self.minusBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.minusBtn.widthAnchor.constraint(equalTo: self.minusBtn.heightAnchor).isActive = true
        
        self.minusBtn.setTitle("-", for: .normal)
        self.minusBtn.titleLabel?.font = .systemFont(ofSize: 24)
        self.minusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.minusBtn.layer.cornerRadius = 5
        
        self.minusBtn.addTarget(self, action: #selector(self.changeCount(sender:)), for: [.touchDown,.touchUpInside])
        
        self.view.addSubview(self.plusBtn)
        self.plusBtn.translatesAutoresizingMaskIntoConstraints = false
        self.plusBtn.centerYAnchor.constraint(equalTo: self.countLabel.centerYAnchor).isActive = true
        self.plusBtn.leftAnchor.constraint(equalTo: self.countLabel.rightAnchor, constant: 32).isActive = true
        self.plusBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.plusBtn.widthAnchor.constraint(equalTo: self.minusBtn.heightAnchor).isActive = true
        
        self.plusBtn.setTitle("+", for: .normal)
        self.plusBtn.titleLabel?.font = .systemFont(ofSize: 24)
        self.plusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.plusBtn.layer.cornerRadius = 5
        
        self.plusBtn.addTarget(self, action: #selector(self.changeCount(sender:)), for: [.touchDown,.touchUpInside])
        
        self.countLabel.textColor = UIColor(r: 185, g: 185, b: 185)
        self.minusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.minusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.plusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.plusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        
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
        
        
        guard self.textFieldType == .name, let user = self.anotherUser else { return }
        self.textField.isHidden = false
        self.pastBtn.isHidden = false
        self.idTypeBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.idTypeBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        self.pastBtn.setImage(UIImage(named: "defaultPhoto"), for: .normal)
        self.textField.attributedPlaceholder = NSAttributedString(string: "Номер пользователя", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
        self.phomeTypeBtn.backgroundColor = UIColor(r: 255, g: 219, b: 208)
        self.phomeTypeBtn.setTitleColor(UIColor(r: 222, g: 65, b: 16), for: .normal)
        let image = user.imageData != nil && !(user.imageData?.isEmpty ?? true) ? UIImage(data: user.imageData!) : UIImage(named: "avatar")
        self.avatarView.image = image
        self.getUser(value: nil)
        
    }
    
    @objc func sendSms(){
        guard let anotherUser = self.anotherUser else { return }
        let valentines = anotherUser.valentines + self.countHerts
        
        guard let url = URL(string: "https://valentinkilar.herokuapp.com/userUpdate?phone=\(String(self.curentUser.phone))&votedfor=\(String(anotherUser.phone))&likes=\(self.countHerts)") else {
            let alert = UIAlertController(title: "Неправильный код", message: "error in code send", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self.present(alert, animated: true)
                }
                return
            }
            DispatchQueue.main.async {
                Datamanager.shared.updateProperty(of: anotherUser, value:valentines , for: #keyPath(UserModel.valentines))
                //если у пользователя нет бесплатного лайка или общее количество лайков больше одного значит он использует доанытные
                if !self.isFree || self.countHerts > 1{
                    //из баланса списываем количество отправленных лайков - 1(если есть бесплатный лайк)
                    let valent = self.curentUser.coins - self.countHerts + (self.isFree ? 1 : 0)
                    Datamanager.shared.updateProperty(of: self.curentUser, value: valent,  for: #keyPath(UserModel.coins))
                    
                }
                
                var votes = self.curentUser.votesData?.jsonDictionary ?? [:]
                votes[anotherUser.phone] = 1
                Datamanager.shared.updateProperty(of: self.curentUser, value: votes.jsonData as Any, for: #keyPath(UserModel.votesData))
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        task.resume()
        
    }
    
    func changeuserCoins(){
        //        https://valentinkilar.herokuapp.com/userUpdate
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        guard self.textField.frame.maxY + keyboardHeight > self.view.frame.height else { return }
        self.height = self.textField.frame.maxY + keyboardHeight - self.view.frame.height
        self.avatarTop?.constant -= self.height
        self.needApp = true
    }
    
    @objc func hideKeyboard(){
        self.textField.resignFirstResponder()
        guard self.needApp else { return }
        self.avatarTop?.constant += self.height
        self.needApp = false
    }
    
    var timer: Timer? = nil
    
    var repetsCount: Int = 0
    
    var isRuning: Bool = false {
        didSet{
            guard !self.isRuning else { return }
            self.repetsCount = 0
        }
    }
    
    @objc func changeCount(sender: UIButton){
        self.isRuning = !self.isRuning
        guard self.isRuning else {
            self.timer?.invalidate()
            return
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            guard (self.countHerts != self.maxHerts + (self.isFree ? 1 : 0) || sender == self.minusBtn) && self.countHerts > 0 else { self.timer?.invalidate(); return }
            guard self.textFieldType != .none else { self.timer?.invalidate(); return }
            self.repetsCount += 1
            let dif: Float = Float(self.repetsCount) /  (2 / Float(self.repetsCount))
            let value = Int(sender == self.minusBtn ? -1 * dif  : 1 * dif)
            self.countHerts += value == 0 ? (sender == self.minusBtn ? -1  : 1) : value
        }
        self.timer?.fire()
    }
    
    @objc func changeType(sender: UIButton){
        self.textField.text?.removeAll()
        self.countHerts = -1
        
        self.countLabel.textColor = UIColor(r: 185, g: 185, b: 185)
        self.minusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.minusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.plusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.plusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.sendBtn.tintColor = UIColor(r: 185, g: 185, b: 185)
        self.sendBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.sendBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        
        self.sendBtn.setTitle("Отправить", for: .normal)
        self.countLabel.text = "0"
        
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
    
    func getUser(value: String?){
        let string: String
        if self.textFieldType == .id{
            string = "https://valentinkilar.herokuapp.com/userGet?uuid=\(String((value ?? self.anotherUser?.id)!))"
        }else{
            string =  "https://valentinkilar.herokuapp.com/userGet?phone=\(String((value ?? self.anotherUser?.phone)!))"
        }
        
        guard let url = URL(string: string) else { return }
//        https://valentinkilar.herokuapp.com/photo?phone=79956881638&get=1
        
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self.present(alert, animated: true)
                    self.hideSpinner()
                }
                return
            }
            
            guard let jsoon = data?.jsonDictionary, let phone = jsoon["Phone"] as? Int else {
                self.anotherUser = UserModel.createUser(phone: value!, type: .another)
                self.usergeteed()
                self.hideSpinner()
                return
            }
            DispatchQueue.main.async {
                let user = UserModel.createUser(phone: String(phone), type: .another)
                user.name = jsoon["Name"] as? String
                user.instagram = jsoon["Insta"] as? String
                self.anotherUser = user
                
                self.usergeteed()
            }
            guard let urlImg = URL(string: "https://valentinkilar.herokuapp.com/photo?phone=\(phone)&get=1") else { return }
            let taskImage = URLSession.shared.dataTask(with: urlImg) {(data, response, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ок", style: .default))
                        self.present(alert, animated: true)
                        self.hideSpinner()
                    }
                    return
                }
                
//                guard let json = data?.jsonDictionary,
//                      let byteArray = json["Photo"] as? String,
//                      let data =  NSData(base64Encoded: byteArray, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)  else
                guard let data = data else {self.hideSpinner(); return }
                DispatchQueue.main.async {
                    self.avatarView.image = UIImage(data: data)
                    self.hideSpinner()
                }
            }
            taskImage.resume()
        }
        
        if value == nil {
            self.usergeteed()
        }else {
            self.showSpinner()
            task.resume()
        }
        
    }
    
    func usergeteed(){
        DispatchQueue.main.async {
            
            if self.isFree || self.maxHerts >= 1{
                self.countHerts = 1
            }else{
                self.countHerts = 0
            }
            
            self.checkColors(oldValue: self.countHerts)
            
            guard self.countHerts != 0 else { return }
            
            self.countLabel.textColor = UIColor(r: 255, g: 95, b: 45)
            self.minusBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
            self.plusBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
            
            self.sendBtn.backgroundColor = UIColor(r: 255, g: 239, b: 234)
            self.sendBtn.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
            self.sendBtn.tintColor = UIColor(r: 255, g: 95, b: 45)
            
            if let name = self.anotherUser?.name{
                self.name.text = name
            }
            if self.anotherUser?.name == nil, self.textField.text == nil {
                self.textField.text = "Незнакомец"
            }
            self.insta.text = self.anotherUser?.instagram ?? (self.anotherUser == nil ? "Мы уведомим о вашей отправленной валентики" : "")
            self.avatarView.image = self.anotherUser?.imageData != nil && !(self.anotherUser?.imageData?.isEmpty ?? true) && self.anotherUser != nil ? UIImage(data: self.anotherUser!.imageData!) : UIImage(named: "avatar")
            self.name.isHidden = false
            self.insta.isHidden = false
        }
    }
    
    func checkColors(oldValue: Int){
        if self.countHerts == 0 && !self.isFree && self.maxHerts == 0 {
            self.countLabel.textColor = UIColor(r: 185, g: 185, b: 185)
            self.minusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
            self.minusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
            self.plusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
            self.plusBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
            self.sendBtn.setTitle("У вас нет дополнительных валентинок", for: .normal)
            self.sendBtn.titleLabel?.font = .systemFont(ofSize: 12)
            self.sendBtn.tintColor = UIColor(r: 185, g: 185, b: 185)
            self.sendBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
            self.sendBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
            self.countLabel.text = String(0)
            return
        }
        guard self.countHerts != 0 && (self.countHerts <= self.maxHerts || self.isFree) else { self.countHerts = oldValue; return }
        var needPlusBackground = true
        self.sendBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        if self.countHerts > self.maxHerts + 1 && self.isFree {
            self.countHerts = 1
            self.plusBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
            needPlusBackground = false
        }
        self.countLabel.text = String(self.countHerts)
        if self.countHerts == 1 && self.isFree {
            self.sendBtn.setTitle("Отправить бесплатное", for: .normal)
        }else{
            self.sendBtn.setTitle("Отправить \(self.countHerts)", for: .normal)
        }
        guard self.textFieldType != .none else {
            self.minusBtn.backgroundColor =  UIColor(r: 247, g: 247, b: 247)
            self.plusBtn.backgroundColor =  UIColor(r: 247, g: 247, b: 247)
            return }
        self.minusBtn.backgroundColor = self.countHerts == 1 ? UIColor(r: 247, g: 247, b: 247) :  UIColor(r: 255, g: 239, b: 234)
        guard needPlusBackground else { return }
        self.plusBtn.backgroundColor = self.countHerts >= (self.maxHerts + (self.isFree ? 1 : 0)) ? UIColor(r: 247, g: 247, b: 247) : UIColor(r: 255, g: 239, b: 234)
        
        
    }
    
}

import Contacts
extension SendHertsVC: Conactdelegate{
    func getConact(name: String, phone: String) {
        do{
            let phone = try PhoneNumberKit().parse(phone)
            let number = String(phone.countryCode) + String(phone.nationalNumber)
            self.textField.text = number
            self.name.text = name
            self.getUser(value: number)
        }catch{
            let alert = UIAlertController(title: "Неправильный формат номера", message: "Выберите другой или введите позже", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self.present(alert, animated: true)
        }
    }
}

extension SendHertsVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.avatarView.image = UIImage(named: "avatar")
        self.insta.isHidden = true
        self.name.isHidden = true
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if var text = textField.text, PhoneNumberKit().isValidPhoneNumber(text), self.textField.text?.first == "+"{
            text.removeFirst()
            self.getUser(value: text)
            return true
        }
        guard textField.text?.count == 36, let text = textField.text else { return true}
        self.getUser(value: text)
        return true
    }
}

enum FiledType{
    case none
    case id
    case phone
    case name
}

struct ScreenTheme {
    
    static var isXFormat: Bool {
        return UIScreen.main.bounds.height / UIScreen.main.bounds.width >= 896.0 / 414.0
    }
    
}
