//
//  PhoneVC.swift
//  Sweetheart
//
//  Created by anmin on 03.02.2021.
//

import UIKit
import PhoneNumberKit

class PhoneVC: LoaderVC{
    var weloomeLabel = UILabel()
    var phoneFiled = MyGBTextField()
    let phomeNumberKit = PhoneNumberKit()
    
    var sendBtn = UIButton()
    
    var phomeIsValid: Bool = false {
        didSet{
            guard self.phomeIsValid != oldValue else { return }
            let backgroundColor = self.phomeIsValid ? UIColor(r: 255, g: 95, b: 45) :  UIColor(r: 247, g: 247, b: 247)
            let titleColor = self.phomeIsValid ? UIColor(r: 255, g: 248, b: 235) : UIColor(r: 185, g: 185, b: 185)
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
        
        let fakeField = UIView()
        self.view.addSubview(fakeField)
        fakeField.translatesAutoresizingMaskIntoConstraints = false
        fakeField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -32).isActive = true
        fakeField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        fakeField.topAnchor.constraint(equalTo: self.weloomeLabel.bottomAnchor, constant: 40).isActive = true
        fakeField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        fakeField.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        fakeField.layer.cornerRadius = 7
        
        self.view.addSubview(self.phoneFiled)
        self.phoneFiled.translatesAutoresizingMaskIntoConstraints = false
        self.phoneFiled.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -32).isActive = true
        self.phoneFiled.leftAnchor.constraint(equalTo: fakeField.leftAnchor, constant: 24).isActive = true
        self.phoneFiled.topAnchor.constraint(equalTo: self.weloomeLabel.bottomAnchor, constant: 40).isActive = true
        self.phoneFiled.heightAnchor.constraint(equalToConstant: 56).isActive = true
            
        
        self.phoneFiled.setLeftPaddingPoints(32)
        self.phoneFiled.withPrefix = true
        self.phoneFiled.withFlag = true
        self.phoneFiled.withExamplePlaceholder = true
        if !self.phoneFiled.withExamplePlaceholder {
            let attributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 18), .foregroundColor : UIColor(red: 114, green: 114, blue: 114, alpha: 1)]
            let attributedString = NSAttributedString(string: "Номер телефона", attributes: attributes)
            self.phoneFiled.attributedPlaceholder = attributedString
        }
        self.phoneFiled.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.phoneFiled.layer.cornerRadius = 7
        self.phoneFiled.textColor = UIColor(r: 114, g: 114, b: 114)
        
        
        self.phoneFiled.addTarget(self, action: #selector(self.textFieldTyping(textField:)), for: .editingChanged)
        
        self.view.addSubview(self.sendBtn)
        self.sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sendBtn.topAnchor.constraint(equalTo: self.phoneFiled.bottomAnchor, constant: 24).isActive = true
        self.sendBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.sendBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -32).isActive = true
        self.sendBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
    
        self.sendBtn.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.sendBtn.setTitleColor(UIColor(r: 185, g: 185, b: 185), for: .normal)
        self.sendBtn.setTitle("Отправить код", for: .normal)
        self.sendBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        self.sendBtn.addTarget(self, action: #selector(self.sendCode), for: .touchUpInside)
        
    }
    
    @objc func sendCode(){
        guard self.phomeIsValid, let number = self.phoneFiled.phoneNumber?.nationalNumber, let code = self.phoneFiled.phoneNumber?.countryCode else { return }
        
        self.showSpinner()
        let url = URL(string: "https://valentinkilar.herokuapp.com/smsSend?phone=\(code)\(number)")!


        if  let date = UserDefaults.standard.value(forKey: "SenCode") as? Date {
            let dateInteval = Date().timeIntervalSince(date)
            guard dateInteval >= 300 else {
                let alert = UIAlertController(title: "Вы превысили кол-во запросов", message: "Повторить запрос кода можно через 5 минут", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
                alert.addAction(UIAlertAction(title: "У меня уже есть код", style: .default, handler: { (_) in
                    let vc = PaswordVC()
                    vc.phone = "\(code)\(number)"
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hideSpinner()
                }))
                
                self.present(alert, animated: true)
                self.hideSpinner()
                return
            }
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ошибка отправки данных", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self.present(alert, animated: true)
                    self.hideSpinner()
                }
                return
            }
            let time = Date()
            UserDefaults.standard.setValue(time, forKeyPath: "SenCode")
            DispatchQueue.main.async {
                let vc = PaswordVC()
                vc.phone = "\(code)\(number)"
                self.navigationController?.pushViewController(vc, animated: true)
                self.hideSpinner()
            }
        }
//
        task.resume()

    }
    
    @objc func textFieldTyping(textField:UITextField)
    {
        self.phomeIsValid = self.phoneFiled.isValidNumber
    }
}




class MyGBTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get {
            return "RU"
        }
        set {} // exists for backward compatibility
    }
}
