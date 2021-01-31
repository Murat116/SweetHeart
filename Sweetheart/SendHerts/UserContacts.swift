//
//  UserContacts.swift
//  Sweetheart
//
//  Created by anmin on 30.01.2021.
//

import UIKit
import ContactsUI

protocol Conactdelegate: class{
    func getConact(conact: CNContact)
}

class FriendsViewController: UIViewController {
    
    var tableView = UITableView()
    
    weak var delegate: Conactdelegate? = nil
    
    var backBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.backBtn)
        self.backBtn.translatesAutoresizingMaskIntoConstraints = false
        self.backBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        self.backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 32).isActive = true
        self.backBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.backBtn.widthAnchor.constraint(equalToConstant: 121).isActive = true
        
        self.backBtn.setImage(UIImage(named: "backBtn"), for: .normal)
        self.backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 23)
        
        self.backBtn.setTitle("Назад", for: .normal)
        self.backBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.backBtn.setTitleColor(.black, for: .normal)
        
        self.backBtn.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 32).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var contacts: [CNContact] = {
        var contacts = [CNContact]()
        
        let contactStore = CNContactStore()
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactThumbnailImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        request.sortOrder = CNContactSortOrder.givenName
        
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        
        
        return contacts
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
    }
    
}

//MARK: - UITableViewDataSource
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        
        if let cell = cell as? FriendCell {
            let contact = self.contacts[indexPath.row]
            cell.configureCell(with: contact)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

//MARK: - UITableViewDelegate
extension FriendsViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getConact(conact: self.contacts[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - CNContactPickerDelegate





class FriendCell: UITableViewCell {
    var contactNameLabel = UILabel()
    var contactPhome = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.contactNameLabel)
        self.contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contactNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.contactNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        
        self.contactNameLabel.font = .boldSystemFont(ofSize: 14)
        self.contactNameLabel.textColor = .black
        
        self.addSubview(self.contactPhome)
        self.contactPhome.translatesAutoresizingMaskIntoConstraints = false
        self.contactPhome.topAnchor.constraint(equalTo: self.contactNameLabel.bottomAnchor, constant: 2).isActive = true
        self.contactPhome.leftAnchor.constraint(equalTo: self.contactNameLabel.leftAnchor).isActive = true
        
        self.contactPhome.font = .systemFont(ofSize: 12)
        self.contactPhome.textColor = UIColor(r: 135, g: 135, b: 135)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(with contact : CNContact) {
        let formatter = CNContactFormatter()
        formatter.style = .fullName
        
        self.contactNameLabel.text = contact.givenName
        let numbers = contact.phoneNumbers
        for num in numbers {
            let numVal = num.value
            if num.label == CNLabelPhoneNumberMobile {
                self.contactPhome.text = numVal.stringValue
                break
            }
            self.contactPhome.text = "Nill"
        }
    }
    
    
}
