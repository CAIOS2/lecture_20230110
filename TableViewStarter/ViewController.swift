//
//  ViewController.swift
//  TableViewStarter
//
//  Created by Education on 17/01/2021.
//

import UIKit

class ViewController: UITableViewController {
  
  //array of Contacts objects
  var contacts = [
    Contacts(name: "Algis", phone: "111-111-111"),
    Contacts(name: "Benas", phone: "333-333-333"),
    Contacts(name: "Bernardas", phone: "444-444-444"),
    Contacts(name: "Jonas", phone: "555-555-555"),
    Contacts(name: "Jurgis", phone: "000-000-000"),
    Contacts(name: "Petras", phone: "666-666-666"),
    Contacts(name: "Zigmas", phone: "777-777-777")
  ]
  
  
  var sortedSectionList: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var firstNameLetterList: Set<String> = []
    for contact in contacts {
      let firstLetter = String(contact.name.prefix(1))
      firstNameLetterList.insert(firstLetter)
      sortedSectionList = firstNameLetterList.sorted()
    }
  }
  
  
  
  
  //MARK: - tableView sections header
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
    header.backgroundColor = .secondarySystemBackground
    let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
    imageView.tintColor = .systemBlue
    header.addSubview(imageView)
    imageView.frame = CGRect(x: 5, y: 5, width: header.frame.size.height-10, height: header.frame.size.height-10)
    let label = UILabel(frame: CGRect(x: 10 + imageView.frame.size.width, y: 5, width: header.frame.size.width - 15 - imageView.frame.size.width, height: header.frame.size.height - 10))
    header.addSubview(label)
    label.text = "\(sortedSectionList[section])"
    return header
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  
  //MARK: - tableView sections and them cells
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
    cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DefaultCell")
    let contacts = contactsInSection(sectionTitle: sortedSectionList[indexPath.section])
    cell.textLabel?.text = contacts[indexPath.row].name
    cell.detailTextLabel?.text = contacts[indexPath.row].phone
    
    return cell
  }
  
  
  //MARK: - tableView sections qty
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sortedSectionList.count
  }
  
  
  //MARK: - tableView cells qty
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contactsInSection(sectionTitle: sortedSectionList[section]).count
  }
  
  //MARK: - didSelectRowAt for Cells
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let contacts = contactsInSection(sectionTitle: sortedSectionList[indexPath.section])
    let selectedContact = contacts[indexPath.row]
    let phoneNumber = selectedContact.phone
    let alert = UIAlertController(title: "Make a Call", message: "Do you want to call \(selectedContact.name) at the number \(phoneNumber)", preferredStyle: .alert)
    let yesAction = UIAlertAction(title: "Yes", style: .default)
    let noAction = UIAlertAction(title: "No", style: .cancel)
    alert.addAction(yesAction)
    alert.addAction(noAction)
    present(alert, animated: true)
  }
  
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      contacts.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }


  
  //MARK: -  func contactsInSection to get contacts in current section
  func contactsInSection(sectionTitle: String) -> [Contacts] {
    
    var contactsInSection: [Contacts] = []
    for contact in contacts {
      if contact.name.prefix(1) == sectionTitle {
        contactsInSection.append(contact)
      }
    }
    // perrikiuoja irasus pagal name
    contactsInSection.sort{
      $0.name < $1.name
    }
    return contactsInSection
  }
}
