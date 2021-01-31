//
//  UserContacts.swift
//  Sweetheart
//
//  Created by anmin on 30.01.2021.
//

import UIKit
import ContactsUI

class FriendsViewController: UITableViewController {
  var friendsList = Friend.defaultContacts()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.tintColor = .white
  }
  
}

//MARK: - UITableViewDataSource
extension FriendsViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return friendsList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
    
    if let cell = cell as? FriendCell {
      let friend = friendsList[indexPath.row]
      cell.friend = friend
    }
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension FriendsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // 1
    let friend = friendsList[indexPath.row]
    let contact = friend.contactValue
    // 2
    let contactViewController = CNContactViewController(forUnknownContact: contact)
    contactViewController.hidesBottomBarWhenPushed = true
    contactViewController.allowsEditing = false
    contactViewController.allowsActions = false
    // 3
    navigationController?.navigationBar.tintColor = .blue
    navigationController?.pushViewController(contactViewController, animated: true)
  }
}

//MARK: - CNContactPickerDelegate
extension FriendsViewController: CNContactPickerDelegate {
  func contactPicker(_ picker: CNContactPickerViewController,
                     didSelect contacts: [CNContact]) {
    let newFriends = contacts.compactMap { Friend(contact: $0) }
    for friend in newFriends {
      if !friendsList.contains(friend) {
        friendsList.append(friend)
      }
    }
    tableView.reloadData()
  }
}

class Friend {
  let firstName: String
  let lastName: String
  let workEmail: String
  var identifier: String?
  let profilePicture: UIImage?
  var storedContact: CNMutableContact?
  var phoneNumberField: (CNLabeledValue<CNPhoneNumber>)?
  
  init(firstName: String, lastName: String, workEmail: String, profilePicture: UIImage?){
    self.firstName = firstName
    self.lastName = lastName
    self.workEmail = workEmail
    self.profilePicture = profilePicture
  }
  
  static func defaultContacts() -> [Friend] {
    return [
      Friend(firstName: "Mic", lastName: "Pringle", workEmail: "mic@example.com", profilePicture: UIImage(named: "MicProfilePicture")),
      Friend(firstName: "Ray", lastName: "Wenderlich", workEmail: "ray@example.com", profilePicture: UIImage(named: "RayProfilePicture")),
      Friend(firstName: "Sam", lastName: "Davies", workEmail: "sam@example.com", profilePicture: UIImage(named: "SamProfilePicture")),
      Friend(firstName: "Greg", lastName: "Heo", workEmail: "greg@example.com", profilePicture: UIImage(named: "GregProfilePicture"))]
  }
}

extension Friend: Equatable {
  static func ==(lhs: Friend, rhs: Friend) -> Bool{
    return lhs.firstName == rhs.firstName &&
      lhs.lastName == rhs.lastName &&
      lhs.workEmail == rhs.workEmail &&
      lhs.profilePicture == rhs.profilePicture
  }
}

extension Friend {
  var contactValue: CNContact {
    let contact = CNMutableContact()
    contact.givenName = firstName
    contact.familyName = lastName
    contact.emailAddresses = [CNLabeledValue(label: CNLabelWork, value: workEmail as NSString)]
    if let profilePicture = profilePicture {
      let imageData = profilePicture.jpegData(compressionQuality: 1)
      contact.imageData = imageData
    }
    if let phoneNumberField = phoneNumberField {
      contact.phoneNumbers.append(phoneNumberField)
    }
    return contact.copy() as! CNContact
  }
  
  convenience init?(contact: CNContact) {
    guard let email = contact.emailAddresses.first else { return nil }
    let firstName = contact.givenName
    let lastName = contact.familyName
    let workEmail = email.value as String
    var profilePicture: UIImage?
    if let imageData = contact.imageData {
      profilePicture = UIImage(data: imageData)
    }
    self.init(firstName: firstName, lastName: lastName, workEmail: workEmail, profilePicture: profilePicture)
    if let contactPhone = contact.phoneNumbers.first {
      phoneNumberField = contactPhone
    }
  }
}

class FriendCell: UITableViewCell {
var contactNameLabel: UILabel!
  var contactEmailLabel: UILabel!
  var contactImageView: UIImageView! {
    didSet {
      contactImageView.layer.masksToBounds = true
      contactImageView.layer.cornerRadius = 22.0
    }
  }
  
  var friend : Friend? {
    didSet {
      configureCell()
    }
  }
  
  private func configureCell() {
    let formatter = CNContactFormatter()
    formatter.style = .fullName
    guard let friend = friend,
      let name = formatter.string(from: friend.contactValue) else { return }
    contactNameLabel.text = name
    contactEmailLabel.text = friend.workEmail
    contactImageView.image = friend.profilePicture ?? UIImage(named: "PlaceholderProfilePic")
  }
}
