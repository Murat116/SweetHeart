//
//  PhoneVC.swift
//  Sweetheart
//
//  Created by anmin on 03.02.2021.
//

import UIKit
import PhoneNumberKit

class PhoneVC: UIViewController{
    var weloomeLabel = UILabel()
    var phoneFiled = MyGBTextField()
    let phomeNumberKit = PhoneNumberKit()
    
    var sendBtn = UIButton()
    
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
        self.sendBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.sendBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant:  -32).isActive = true
        self.sendBtn.heightAnchor.constraint(equalToConstant: 49).isActive = true
    
    }
    
    @objc func textFieldTyping(textField:UITextField)
    {
        self.phoneFiled.isValidNumber
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
