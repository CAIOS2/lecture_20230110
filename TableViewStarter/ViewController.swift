//
//  ViewController.swift
//  TableViewStarter
//
//  Created by Education on 17/01/2021.
//

import UIKit



class ViewController: UITableViewController {
    
    var contacts: [Contact] = [
        Contact(name: "Jogaila K", surname: "K.", phone: "+370"),
        Contact(name: "Mindaugas P", surname: "P", phone: "+371"),
        Contact(name: "Vytautas D", surname: "D", phone: "+372"),
        Contact(name: "Algirdas P", surname: "P", phone: "+371"),
        Contact(name: "Rolandas R", surname: "R", phone: "+371")
    ]
    
    var sortedSectionList: [String] = []

    override func viewDidLoad() {
        tableView.delegate = self
         
        
        //MARK: susiformuojame array sortedSectionList
            var firstSurnameLetterList: Set<String> = []
            for contact in contacts {
                let firstLetter: String = String(contact.surname.prefix(1))
                
                firstSurnameLetterList.insert(firstLetter)
                sortedSectionList = firstSurnameLetterList.sorted()
            }
    }
    
    //MARK: tableView sections header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return "::  \(sortedSectionList[section])"
    }
    
    //MARK: tableView sections and them cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell",
                                                 for: indexPath) // Cell registered in the Main.storyboard
        
        // reikalingas kad pagautu skirtingus stilius
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DefaultCell")
        
        let contacts = contactsInSection(sectionTitle: sortedSectionList[indexPath.section])
        
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = contacts[indexPath.row].phone

        return cell
    }
    
    // rodo alerta paspaudus ant celes:
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        showAlert()
    }
    
    // celes istrynimas
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//           return true
//       }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //            self.tableView.reloadData()
            
        }
    }

    
    //MARK: tableView cells qty
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsInSection(sectionTitle: sortedSectionList[section]).count
    }
    
    //MARK: tableView sections qty
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedSectionList.count
    }
    
    
    //MARK: func contactsInSection to get contacts in current section
    func contactsInSection(sectionTitle: String) -> [Contact] {
        
        var contactsInSection: [Contact] = []
        for contact in contacts {
            if contact.surname.prefix(1) == sectionTitle {
                contactsInSection.append(contact)
                print("append")
            }
        }
        // perrikiuoja irasus pagal name
         contactsInSection.sort{
            $0.name < $1.name
          }
        return contactsInSection
    }
    
    func showAlert() {
        
        let callAlert = UIAlertController(
            title: "Caller", message: "Do you want to call to user ?", preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK", style: .default) {_ in
            self.dismiss(animated: true)
        }
        callAlert.addAction(alertAction)
        present(callAlert, animated: true, completion: nil)
    }
}
    
    
    


class Contact {
    var name: String
    var surname: String
    var phone: String
    
    init(name: String, surname: String, phone: String) {
        self.name = name
        self.surname = surname
        self.phone = phone
    }

}
























//struct Contact {
//    let name: String
//    let number: String
//}
// 
//var contacts: [Contact] = [Contact(name: "A", number: "123"), Contact(name: "B", number: "345")]
// 
//class ViewController: UITableViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell",
//                                                 for: indexPath) // Cell registered in the Main.storyboard
//        
//        cell.textLabel?.text = contacts[indexPath.row].name
//        cell.detailTextLabel?.text = contacts[indexPath.row].number
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts.count
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//}
//
