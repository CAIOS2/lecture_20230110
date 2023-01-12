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
        Contact(name: "Tadas P", surname: "P", phone: "somet")
    ]

    var tableData: [String: [Contact]] {
        get {
            Dictionary(grouping: contacts, by: { contact in String(contact.surname.prefix(1)) })
        }
    }

    var tableSections: [String] {
        get {
            tableData.keys.sorted { $0.caseInsensitiveCompare($1) == .orderedAscending }
        }
    }
    
    //MARK: tableView sections header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return tableSections[section]
    }
    
    //MARK: tableView sections and them cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell",
                                                 for: indexPath) // Cell registered in the Main.storyboard

        let sectionKey = tableSections[indexPath.section]
        let objectsInSection = tableData[sectionKey]
        let object = objectsInSection?[indexPath.row]
        
        cell.textLabel?.text = object?.name
        cell.detailTextLabel?.text = object?.phone

        return cell
    }
    
    //MARK: tableView cells qty
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = tableSections[section]
        let objectsInSection = tableData[sectionKey]
        return objectsInSection?.count ?? 0
    }
    
    //MARK: tableView sections qty
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sectionKey = tableSections[indexPath.section]
            let objectsInSection = tableData[sectionKey]
            let object = objectsInSection?[indexPath.row]

            self.contacts.removeAll { $0.phone == object?.phone }
            self.tableView.reloadData()
        }
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


