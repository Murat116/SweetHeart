//
//  SignIn.swift
//  Sweetheart
//
//  Created by anmin on 27.01.2021.
//

import UIKit
import WebKit

class SignInVIewController: UIViewController {
    
    //----------------------------------------------------------------------
    
    private var loginField = SignInTextField(type: .login)
    private var passwordField = SignInTextField(type: .password)
    private var confirmationField = SignInTextField(type: .confirmation)
    
    //----------------------------------------------------------------------
    
    private var nextBtnTopToPass: NSLayoutConstraint? = nil
    private var nextBtnTopToConfirm: NSLayoutConstraint? = nil
    
    //----------------------------------------------------------------------
    
    private var sigInBtn = UIButton()
    private var privacyPolicyBtn = UIButton()
    
    //----------------------------------------------------------------------
    
    private var isRegistration: Bool = true {
        didSet {
            let title = self.isRegistration ? "Sign In" : "Create account"
            self.sigInBtn.setTitle(title, for: [])
        }
    }
    
    //----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //----------------------------------------------------------------------
    

    
    @objc func sigIn() {
        
        self.isRegistration = !self.isRegistration
        UIView.animate(withDuration: 0.3) { self.prepareFieldsForSignIn() }
    }
    
    //----------------------------------------------------------------------
    
    @objc func hideKeyboard() {
        
        self.loginField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.confirmationField.resignFirstResponder()
    }
    
    //----------------------------------------------------------------------
    
    @objc func nextVC(btn: UIButton) {
        
        guard self.loginField.isValid else {
            showSignAlert(text: "Username doesn't conform rules")
            return
        }
        
        if self.isRegistration {
            guard self.passwordField.isValid, self.confirmationField.isValid,
                let login = self.loginField.text,
                let password = self.passwordField.text else {
                    showSignAlert(text: "Password doesn't conform rules")
                return
            }
            if self.passwordField.text == self.confirmationField.text {
//                self.output.createUser(login: login, password: password)
                return
            } else {
                showSignAlert(text: "Password and confirmation not equal")
            }
        } else {
            
            guard let login = self.loginField.text, let password = self.passwordField.text else {
                showSignAlert(text: "Fill all fields")
                return
            }

//            self.output.signIn(login: login, password: password)
            return
        }
    }
    
    
    @objc func privacyPolicyAction() {
//        self.output.privacyPolicyTapped()
    }
    
}


extension SignInVIewController {
    
    
    func setUp(){
        
        self.view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        
        self.view.addSubview(self.loginField)
        self.loginField.translatesAutoresizingMaskIntoConstraints = false
        self.loginField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        self.loginField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive  = true
        self.loginField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.loginField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.view.addSubview(self.passwordField)
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: 15).isActive  = true
        self.passwordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.passwordField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.view.addSubview(self.confirmationField)
        self.confirmationField.translatesAutoresizingMaskIntoConstraints = false
        self.confirmationField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        self.confirmationField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 33).isActive = true
        self.confirmationField.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 15).isActive = true
        self.confirmationField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.passwordField.delegate = self
        self.loginField.delegate = self
        self.confirmationField.delegate = self
        
        
        let nextVcBtn = UIButton()
        self.view.addSubview(nextVcBtn)
        nextVcBtn.translatesAutoresizingMaskIntoConstraints = false
        
        nextVcBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -33).isActive = true
        nextVcBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant:  33).isActive = true

        self.nextBtnTopToPass = nextVcBtn.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 15)
        self.nextBtnTopToPass!.isActive = true
        self.nextBtnTopToConfirm = nextVcBtn.topAnchor.constraint(equalTo: self.confirmationField.bottomAnchor, constant: 15)
        
        nextVcBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        nextVcBtn.backgroundColor = UIColor(red: 0.131, green: 0.309, blue: 0.939, alpha: 1)
        nextVcBtn.layer.cornerRadius = 6
        
        nextVcBtn.setTitle("Next", for: .normal)
        
        nextVcBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        nextVcBtn.addTarget(self, action: #selector(self.nextVC), for: .touchUpInside)
        
        self.view.addSubview(self.sigInBtn)
        self.sigInBtn.translatesAutoresizingMaskIntoConstraints = false
        self.sigInBtn.topAnchor.constraint(equalTo: nextVcBtn.bottomAnchor, constant: 15).isActive = true
        self.sigInBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.sigInBtn.setTitle("Sign in", for: .normal)
        self.sigInBtn.setTitleColor( UIColor(red: 0.287, green: 0.287, blue: 0.287, alpha: 1)
            , for: .normal)
        self.sigInBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        self.sigInBtn.addTarget(self, action: #selector(self.sigIn), for: .touchUpInside)
        
        
        
        self.view.addSubview(self.privacyPolicyBtn)
        
        self.privacyPolicyBtn.translatesAutoresizingMaskIntoConstraints = false
        self.privacyPolicyBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        self.privacyPolicyBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.privacyPolicyBtn.addTarget(self, action: #selector(self.privacyPolicyAction), for: .touchUpInside)
        self.privacyPolicyBtn.setTitle("Privacy Policy", for: .normal)
        self.privacyPolicyBtn.setTitleColor( UIColor(red: 0.287, green: 0.287, blue: 0.287, alpha: 1)
        , for: .normal)
        self.privacyPolicyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapRec)
    }
}

//----------------------------------------------------------------------

extension SignInVIewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let signInField = textField as? SignInTextField else { return false}
        if signInField.type == .login{
            return signInField.isValid
        }
        return true
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = textField as? SignInTextField else { return false }
        
        switch textField.type {
        case .login:
            let nextField = passwordField
            nextField.becomeFirstResponder()
        case .password:
            if (self.isRegistration && !confirmationField.isHidden) {
                let nextField = confirmationField
                nextField.becomeFirstResponder()
            } else {
                self.hideKeyboard()
            }
        case .confirmation:
            self.hideKeyboard()
        case .none:
            break
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let signInField = textField as? SignInTextField else { return }
        
        signInField.placeholderIsHidden = textField.text?.count == 0
        
        switch signInField.type {
        case .login:
            _ = signInField.isValid
            
        case .password, .confirmation:
            
            guard self.isRegistration else {
                if signInField.type != .password { return }
                _ = signInField.isValid
                return
            }
            
            if self.confirmationField.isHidden, signInField.isValid {
                self.confirmationField.isHidden = false
                UIView.animate(withDuration: 0.3) { [unowned self] in
                    self.nextBtnTopToPass?.isActive = false
                    self.nextBtnTopToConfirm?.isActive = true
                    self.view.layoutIfNeeded()
                }
                return
            } else if self.confirmationField.isHidden {
                return
            } else if self.confirmationField.text == "" && signInField.type == .password {
                return
            }
            
            if self.confirmationField.text == self.passwordField.text {
                
                self.confirmationField.isValid = true
                self.passwordField.isValid = true
            } else {
                
                self.confirmationField.isValid = false
                self.passwordField.isValid = false
            }
        case .none:
            break
        }
    }

}

//----------------------------------------------------------------------

extension SignInVIewController {
    private class SignInTextField: UITextField {
        
        fileprivate var type: SigInFieldType? = nil
        private let label = UILabel()
        
        init(type: SigInFieldType) {
            super.init(frame: .zero)
            self.type = type
            self.configure(type: type)
        }
        
        fileprivate var isValid: Bool {
            get {
                self.isValid = self.checkField()
                return self.checkField()
            } set {
                self.label.textColor = newValue ? UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1) : .red
                self.textColor = newValue ? .white : .red
            }
        }
        
        fileprivate var placeholderIsHidden: Bool = false {
            didSet {
                UIView.animate(withDuration: 0.2) { [unowned self] in
                    self.label.isHidden = self.placeholderIsHidden
                }
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configure(type: SigInFieldType) {
            
            let attributes: [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: 18), .foregroundColor : UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1)]
            let attributedString = NSAttributedString(string: type.rawValue, attributes: attributes)
            self.attributedPlaceholder = attributedString

            self.keyboardType = .default
            self.isSecureTextEntry = type.isSecure
            
            self.textColor = .white

            self.layer.borderColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1).cgColor
            self.layer.borderWidth = 1
            self.layer.cornerRadius = 4

            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
            
            let labelView = UIView()
            self.addSubview(labelView)
            labelView.frame = CGRect(x: 0, y: 0, width: 200, height: 10 )
            
            labelView.addSubview(self.label)
            self.label.frame = CGRect(x: 22, y: 5, width: 200, height: 10 )
            self.label.font = UIFont.systemFont(ofSize: 10)
            self.label.text = type.rawValue
            self.label.textColor = UIColor(red: 0.314, green: 0.314, blue: 0.314, alpha: 1)
            
            self.label.isHidden = true
            
            self.isHidden = self.type == .confirmation
        }
        
        func checkField() -> Bool {
            switch self.type {
            case .login:
                let regex = "\\w{5,18}"
                let еest = NSPredicate(format:"SELF MATCHES %@", regex)
                return еest.evaluate(with: self.text)
            case .password, .confirmation:
                let regex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
                let test = NSPredicate(format: "SELF MATCHES %@", regex)
                return test.evaluate(with: self.text)
                //return self.text?.count ?? 0 >= 8
            default:
                return false
            }
        }
    }
}

//----------------------------------------------------------------------

extension SignInVIewController {
    private enum SigInFieldType: String {
        
        case login = "Phone Number"
        case password = "Password"
        case confirmation = "Password Confirmation"

        var isSecure: Bool{
            return self != .login
        }
    }
}

extension SignInVIewController {
    
    func prepareFieldsForSignIn() {
        self.loginField.text = ""
        self.passwordField.text = ""
        self.confirmationField.text = ""
        self.loginField.placeholderIsHidden = true
        self.confirmationField.placeholderIsHidden = true
        self.passwordField.placeholderIsHidden = true
        self.confirmationField.isHidden = true
        self.nextBtnTopToPass?.isActive = true
        self.nextBtnTopToConfirm?.isActive = false
        self.view.layoutIfNeeded()
    }
    
    func showSignAlert(text: String) {
//        self.output.showSignAlert(text: text)
    }
}

