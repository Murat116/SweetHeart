//
//  PaswordVC.swift
//  Sweetheart
//
//  Created by anmin on 03.02.2021.
//

import UIKit

class PaswordVC: LoaderVC {
    
    var backBtn = UIButton()
    var weloomeLabel = UILabel()
    
    var paswordStackView = UIStackView()
    
    var phone: String!
    
    var sendBtn = UIButton()
    
    var subviews = [UIView]()
    var curentNumber: Int = 0 {
        didSet{
            guard self.curentNumber >= subviews.count || self.curentNumber < 0  else { return }
            self.curentNumber = 0
        }
    }
    
    var codeisValid: Bool = false {
        didSet{
            guard self.codeisValid != oldValue else { return }
            let backgroundColor = self.codeisValid ? UIColor(r: 255, g: 95, b: 45) :  UIColor(r: 247, g: 247, b: 247)
            let titleColor = self.codeisValid ? UIColor(r: 255, g: 248, b: 235) : UIColor(r: 185, g: 185, b: 185)
            self.sendBtn.backgroundColor = backgroundColor
            self.sendBtn.setTitleColor(titleColor, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(self.weloomeLabel)
        self.weloomeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.weloomeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        self.weloomeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        
        self.weloomeLabel.text = "Добро пожаловать"
        self.weloomeLabel.textColor = .black
        self.weloomeLabel.font = .boldSystemFont(ofSize: 24)
        
        self.view.addSubview(self.backBtn)
        self.backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        self.backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 38).isActive = true
        self.backBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.backBtn.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        self.backBtn.setImage(UIImage(named: "backBtn"), for: .normal)
        self.backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 23)
        
        self.backBtn.setTitle("Проверка номера", for: .normal)
        self.backBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.backBtn.setTitleColor(.black, for: .normal)
        self.backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        
        for i in 0...4{
            subviews.append(self.createField(number: i))
        }
        
        self.paswordStackView = UIStackView(arrangedSubviews: subviews)
        
        self.view.addSubview(self.paswordStackView)
        self.paswordStackView.translatesAutoresizingMaskIntoConstraints = false
        self.paswordStackView.topAnchor.constraint(equalTo: self.weloomeLabel.bottomAnchor, constant: 40).isActive = true
        self.paswordStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.paswordStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.paswordStackView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        self.paswordStackView.axis = .horizontal
        self.paswordStackView.distribution = .fillEqually
        self.paswordStackView.alignment = .fill
        self.paswordStackView.spacing = 17
        
        self.view.addSubview(self.sendBtn)
        self.sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sendBtn.topAnchor.constraint(equalTo: self.paswordStackView.bottomAnchor, constant: 24).isActive = true
        self.sendBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.sendBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -32).isActive = true
        self.sendBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
    
        self.sendBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.sendBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.sendBtn.setTitle("Отправить код", for: .normal)
        self.sendBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        self.sendBtn.addTarget(self, action: #selector(self.sendCode), for: .touchUpInside)
        
        self.subviews[self.curentNumber].becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clipboardChanged),
                                                       name: UIPasteboard.changedNotification, object: nil)
        
    }
    
    @objc func clipboardChanged(){
        
        
    }
    
    func createField(number: Int) -> PaswordFiled{
        let field = PaswordFiled(frame: CGRect(x: 0, y: 0, width: 48, height: 56))
        field.number = number
        field.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        field.textColor = UIColor(r: 147, g: 147, b: 147)
        field.textAlignment = .center
        field.addTarget(self, action: #selector(self.textFieldTyping(textField:)), for: .editingChanged)
        field.deleteDelegate = self
        field.delegate = self
        field.keyboardType = .numberPad
        field.tintColor = UIColor.clear
        field.delegate = self
        field.textContentType = .oneTimeCode
        
        return field
    }
    
    @objc func textFieldTyping(textField:UITextField)
    {
        guard textField.text?.count != 0  else { textField.becomeFirstResponder(); return }
        if textField.text?.count ?? 0 > 1 {
            textField.text?.removeFirst()
        }
        guard self.curentNumber != self.subviews.count - 1 else {
            self.codeisValid = true
            return
        }
        textField.resignFirstResponder()
        self.codeisValid = false
        
        self.curentNumber += 1
        
        let textField = self.subviews[self.curentNumber]
        textField.becomeFirstResponder()
    }
    
    @objc func sendCode(){
        var code: String = ""
        for subview in self.subviews{
            guard let tf = subview as? UITextField, let text = tf.text, text.count == 1 else { return }
            code.append(text)
        }
        guard code.count == 5 else { return }
        
        guard let url = URL(string: "https://valentinkilar.herokuapp.com/phoneConfirm?phone=\(String(self.phone))&code=\(String(code))") else {
            let alert = UIAlertController(title: "Неправильный код", message: "error in code send", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        self.showSpinner()

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil , (response as? HTTPURLResponse)?.statusCode == 200 else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self.present(alert, animated: true)
                    self.hideSpinner()
                }
                return
            }
            DispatchQueue.main.async {
                guard let json = data?.jsonDictionary,
                      let phone = json["Phone"] as? Int,
                      let id = json["UUID"] as? String else { return }
                
                let user  = UserModel.createUser(phone: String(phone), id: id, type: .curent)
                
                if let name = json["Name"] as? String{
                    user.name = name
                }
                
                if let like = json["Likes"] as? Int {
                    user.valentines = like
                }
                
                if let insta = json["Insta"] as? String {
                    user.instagram = insta
                }
                
                if let balance = json["Balance"] as? Int {
                    user.coins = Int(balance)
                }
                
                do{
                    try Datamanager.shared.realm?.write{
                        Datamanager.shared.realm?.add(user)
                        let vc = UserRegistaration()
                        vc.configure(state: .edit, isUserInit: true)
                        self.navigationController?.pushViewController(vc, animated: true)
                        self.hideSpinner()
                    }
                }catch{
                    print(error)
                }
                
            }
        }

        task.resume()
        
        
    }

    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension PaswordVC: PhoneTextFieldDelegate, UITextFieldDelegate{
    func deleteBackward(of textField: UITextField) {
        textField.resignFirstResponder()
        self.curentNumber -= 1
        let tf = self.subviews[self.curentNumber]
        if let text = textField.text, text.isEmpty{
            (tf as? UITextField)?.text?.removeAll()
        }
        tf.becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return (textField as? PaswordFiled)?.number == self.curentNumber
    }
}

protocol PhoneTextFieldDelegate:class {
    func deleteBackward(of textField: UITextField)
}

class PaswordFiled: UITextField{
    var number: Int = 0
    weak var deleteDelegate: PhoneTextFieldDelegate?  = nil
    
    override public func deleteBackward() {
        self.deleteDelegate?.deleteBackward(of: self)
            super.deleteBackward()
        
    }
    
    override func paste(_ sender: Any?) {
        print("do someting")
        super.paste(sender)
    }
    
    
}
