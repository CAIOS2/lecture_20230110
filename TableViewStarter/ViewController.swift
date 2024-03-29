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
    ]
    
    var sortedSectionList: [String] = []

    override func viewDidLoad() {
         
        
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


