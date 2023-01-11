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

                        // Section Name   :     DataObjects
    var tableViewData = [String: [Contact]]()
    var tableViewSectionsCount: Int = 0


    var sectionsNames = [String]()
//    var sectionCount = sectionsNames.count
    var sectionsData = [[Contact]]()


    override func viewDidLoad() {

        //MARK: susiformuojame array sortedSectionList
        var firstSurnameLetterList: Set<String> = []
        for contact in contacts {
            let firstLetter: String = String(contact.surname.prefix(1))

            firstSurnameLetterList.insert(firstLetter)
            sortedSectionList = firstSurnameLetterList.sorted()
        }

        createSections()
    }

    private func createSections() {
        for contact in contacts {
            if let contactArray = tableViewData[contact.surname] {
                // Adds to the section
                var array = Array(contactArray)
                array.append(contact)
                tableViewData[contact.surname] = array
            } else {
                // Creates a new section
                var array = Array<Contact>()
                array.append(contact)
                tableViewData[contact.surname] = array
                tableViewSectionsCount = tableViewSectionsCount + 1
            }
        }

        for key in tableViewData {
            print("For key: \(key.key) there is these values:")
            for value in key.value {
                print("     \(value.name)   \(value.surname)")
            }
        }
    }
    
    //MARK: tableView sections header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {

        for (index, dictValue) in tableViewData.enumerated() {
            if index == section {
                return "::  \(dictValue.key)"
            }
        }


        return "Errror"//"::  \(sortedSectionList[section])"
    }
    
    //MARK: tableView sections and them cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell",
                                                 for: indexPath) // Cell registered in the Main.storyboard
        
        // reikalingas kad pagautu skirtingus stilius
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "DefaultCell")

        var textLabelText = "🐸"
        var detailTextLabelText = "🐸"

        for (index, dictValue) in tableViewData.enumerated() {
            if index == indexPath.section {
                let value = dictValue.value[indexPath.row]
                textLabelText = value.name
                detailTextLabelText = value.phone
            }
        }
        
        cell.textLabel?.text = textLabelText
        cell.detailTextLabel?.text = detailTextLabelText  //= contactsInSection(sectionTitle: sortedSectionList[indexPath.section])[indexPath.row].phone
        return cell
    }
    
    //MARK: tableView cells qty
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        for (index, dictValue) in tableViewData.enumerated() {
            if index == section {
                return dictValue.value.count
            }
        }

        return 0//contactsInSection(sectionTitle: sortedSectionList[section]).count
    }
    
    //MARK: tableView sections qty
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count//sortedSectionList.count
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


