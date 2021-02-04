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
    var avatarBtn = UIButton()
    var topAvatar: NSLayoutConstraint? = nil
    var needUp: Bool = false
    
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
    
    var userModel: UserModel = Datamanager.shared.curentUser!
    
    var isUserInit = false
    
    var state: VCState = .view {
        didSet{
            self.nameField.isUserInteractionEnabled = self.state == .edit
            self.instField.isUserInteractionEnabled = self.state == .edit
            self.nameField.text?.removeAll()
            self.instField.text?.removeAll()
            self.nameField.attributedPlaceholder = NSAttributedString(string: self.userModel.name ?? "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
            self.instField.attributedPlaceholder = NSAttributedString(string: self.userModel.instagram ?? "Instagram", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
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
        self.topAvatar = self.avatarView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 47)
        self.topAvatar?.isActive = true
        self.avatarView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        self.avatarView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        self.avatarView.contentMode = .scaleToFill
        self.avatarView.layer.masksToBounds = false
        self.avatarView.clipsToBounds = true
        
        let image = self.userModel.imageData != nil ? UIImage(data: self.userModel.imageData!) : UIImage(named: "avatar")
        self.avatarView.image = image
        
        self.view.addSubview(self.avatarBtn)
        self.avatarBtn.translatesAutoresizingMaskIntoConstraints = false
        self.avatarBtn.topAnchor.constraint(equalTo: self.avatarView.topAnchor).isActive = true
        self.avatarBtn.leftAnchor.constraint(equalTo: self.avatarView.leftAnchor).isActive = true
        self.avatarBtn.rightAnchor.constraint(equalTo: self.avatarView.rightAnchor).isActive = true
        self.avatarBtn.bottomAnchor.constraint(equalTo: self.avatarView.bottomAnchor).isActive = true
        
        self.avatarBtn.addTarget(self, action: #selector(self.openPicker), for: .touchUpInside)
        
        self.view.addSubview(self.name)
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.name.centerXAnchor.constraint(equalTo: self.avatarView.centerXAnchor).isActive = true
        self.name.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16).isActive = true
        self.name.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.name.font = .boldSystemFont(ofSize: 24)
        self.name.textColor = .black
        self.name.textAlignment = .center
        self.name.text = self.userModel.name ?? "User name"
        
        self.view.addSubview(self.insta)
        self.insta.translatesAutoresizingMaskIntoConstraints = false
        self.insta.topAnchor.constraint(equalTo: self.name.bottomAnchor).isActive = true
        self.insta.centerXAnchor.constraint(equalTo: self.name.centerXAnchor).isActive = true
        self.insta.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.insta.font = .systemFont(ofSize: 14)
        self.insta.textColor = UIColor(r: 114, g: 114, b: 114)
        self.insta.text = self.userModel.instagram ?? "User instagram"
        
        self.view.addSubview(self.place)
        self.place.translatesAutoresizingMaskIntoConstraints = false
        self.place.topAnchor.constraint(equalTo: self.insta.bottomAnchor, constant: 16).isActive = true
        self.place.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.place.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.place.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.place.setImage(UIImage(named: "Star"), for: .normal)
        self.place.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
       
        self.place.titleLabel?.font = .systemFont(ofSize: 14)
        self.place.setTitle("\(self.userModel.placeInTop) место", for: .normal)
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
        self.hearts.setTitle(String(self.userModel.valentines), for: .normal)
        self.hearts.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        
        self.view.addSubview(self.nameField)
        self.nameField.translatesAutoresizingMaskIntoConstraints = false
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.nameField.topAnchor.constraint(equalTo: self.hearts.bottomAnchor, constant: 48).isActive = true
        self.nameField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        self.nameField.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.nameField.attributedPlaceholder = NSAttributedString(string: self.userModel.name ?? "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
        self.nameField.setLeftPaddingPoints(24)
        self.nameField.layer.cornerRadius = 7
        self.nameField.delegate = self
        
        self.view.addSubview(self.instField)
        self.instField.translatesAutoresizingMaskIntoConstraints = false
        self.instField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.instField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.instField.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: 16).isActive = true
        self.instField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        
        self.instField.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        self.instField.attributedPlaceholder = NSAttributedString(string: self.userModel.instagram ?? "Instagram", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 114, g: 114, b: 114) ])
        self.instField.setLeftPaddingPoints(24)
        self.instField.layer.cornerRadius = 7
        self.instField.delegate = self
        
        
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
        self.editbtn.isHidden = self.state == .edit
        
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
        self.saveBtn.isHidden = self.state != .edit
        
        self.saveBtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
        
        self.view.addSubview(self.cancel)
        self.cancel.translatesAutoresizingMaskIntoConstraints = false
        self.cancel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32).isActive = true
        self.cancel.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 4).isActive = true
        self.cancel.topAnchor.constraint(equalTo: self.instField.bottomAnchor, constant: 24).isActive = true
        self.cancel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.cancel.backgroundColor = UIColor(r: 255, g: 239, b: 234)
        self.cancel.titleLabel?.font = .systemFont(ofSize: 16)
        self.cancel.setTitle(self.state == .edit ? "Пропустить" : "Отмена", for: .normal)
        self.cancel.layer.cornerRadius = 8
        self.cancel.setTitleColor(UIColor(r: 255, g: 95, b: 45), for: .normal)
        
        self.cancel.addTarget(self, action: #selector(self.edit(btn:)), for: .touchUpInside)
        self.cancel.isHidden = self.state != .edit
        
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
        
        self.coppy.addTarget(self, action: #selector(self.coppyAction), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tap)
        
        self.view.layoutIfNeeded()
        self.avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func coppyAction(){
        UIPasteboard.general.string = Datamanager.shared.curentUser!.id
    }
    
    @objc func openPicker(){
        guard self.state == .edit else { return }
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
        guard self.instField.frame.maxY + keyboardHeight > self.view.frame.height else { return }
        self.topAvatar?.constant -= 80
        self.needUp = true
    }
    
    @objc func hideKeyboard(){
        self.nameField.resignFirstResponder()
        self.instField.resignFirstResponder()
        guard self.needUp else { return }
        self.needUp = false
        self.topAvatar?.constant += 80
    }
    
    func configure(state: VCState, isUserInit: Bool = false){
        guard let url = URL(string: "https://valentinkilar.herokuapp.com/userGet?phone=79872174506") else {
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

            guard let json = data?.jsonDictionary else { return  }
            DispatchQueue.main.async {
                if let name = json["Name"] as? String, name != self.userModel.name {
                    Datamanager.shared.updateProperty(of: self.userModel, value: name, for: #keyPath(UserModel.name))
                }
                
                if let name = json["Balance"] as? Float, name != Float(self.userModel.coins) {
                    Datamanager.shared.updateProperty(of: self.userModel, value: Int(name), for: #keyPath(UserModel.coins))
                }
                
                if let name = json["Insta"] as? String, name != self.userModel.instagram {
                    Datamanager.shared.updateProperty(of: self.userModel, value: name, for: #keyPath(UserModel.instagram))
                }
                
                if let name = json["VotedFor"] as? [String:Any], name.jsonData != self.userModel.votesData {
                    Datamanager.shared.updateProperty(of: self.userModel, value: name.jsonData, for: #keyPath(UserModel.votesData))
                }
                
                if let name = json["Likes"] as? Int, name != self.userModel.valentines {
                    Datamanager.shared.updateProperty(of: self.userModel, value: name, for: #keyPath(UserModel.valentines ))
                }
            }
           
            
        }

        task.resume()
        
        
        self.isUserInit = isUserInit
        self.backBtn.isHidden = state == .edit
        self.state = state
    }
    
    func sendRequest(_ url: String, parameters: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }

            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(responseObject, nil)
        }
        task.resume()
    }
    
    @objc func edit(btn: UIButton){
        guard !self.isUserInit else {
            let vc = MainVC()
            let navigationViewController = UINavigationController(rootViewController: vc)
            UIApplication.shared.windows.first?.rootViewController = navigationViewController
            return
        }
        UIView.animate(withDuration: 0.2) {
            self.state =  btn == self.editbtn ? .edit : .view
            self.saveBtn.isHidden = btn != self.editbtn
            self.cancel.isHidden = btn != self.editbtn
            self.editbtn.isHidden = btn == self.editbtn
        }
    }
    
    @objc func save(){
        let name = self.nameField.text?.isEmpty ?? true ? self.userModel.name ?? "User" :  self.nameField.text
        let insta = self.instField.text?.isEmpty ?? true ? self.userModel.instagram ?? "Hello friends" : self.instField.text
        let imgData = self.avatarView.image?.pngData()
        
                    var parameters = [String: String]()
        if name != Datamanager.shared.curentUser?.name {
            parameters["name"] = name
            parameters["insta"] = Datamanager.shared.curentUser?.instagram
        }
        
        if insta != Datamanager.shared.curentUser?.instagram {
            parameters["insta"] = name
        }
        
        if imgData != Datamanager.shared.curentUser?.imageData {
            //send to server
        }
        
        parameters["phone"] = "79872174506"
        
        self.sendRequest("https://valentinkilar.herokuapp.com/userUpdate", parameters: parameters) { (_, error) in
            guard error != nil else { return }
            let alert = UIAlertController(title: "Неправильный код", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            self.present(alert, animated: true)
            return
        }
         
        Datamanager.shared.updateProperty(of: self.userModel, value: name, for: #keyPath(UserModel.name))
        Datamanager.shared.updateProperty(of: self.userModel, value: insta, for: #keyPath(UserModel.instagram))
        Datamanager.shared.updateProperty(of: self.userModel, value: imgData, for: #keyPath(UserModel.imageData))
        self.saveBtn.isHidden = true
        self.cancel.isHidden = true
        self.editbtn.isHidden = false
        self.state = .view
    
        guard self.isUserInit else { return }
        let vc = MainVC()
        let navigationViewController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationViewController
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension UserRegistaration: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.nameField {
            self.name.text = textField.text
        }else{
            self.insta.text = textField.text
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nameField {
            self.name.text = textField.text
        }else{
            self.insta.text = textField.text
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}

extension UserRegistaration: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.avatarView.image = image
            self.view.layoutIfNeeded()
            self.avatarView.layer.cornerRadius = self.avatarView.frame.height / 2
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:  true, completion: nil)
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
