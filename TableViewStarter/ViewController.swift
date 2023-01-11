//
//  ViewController.swift
//  TableViewStarter
//
//  Created by Education on 17/01/2021.
//

import UIKit

class ViewController: UITableViewController {
    
   private var contactsByFirstLetter: [String: [Contact]] = [:]
   private var contactFirstLettersSorted: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for contact in contactsList {
            if contactsByFirstLetter[String(contact.name.first!)] != nil {
                contactsByFirstLetter[String(contact.name.first!)]?.append(contact)
            } else {
                contactsByFirstLetter[String(contact.name.first!)] = [contact]
            }
        }
        
        contactFirstLettersSorted = contactsByFirstLetter.keys.sorted()
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell",
                                                 for: indexPath)
        
        cell.textLabel?.text = contactsByFirstLetter[contactFirstLettersSorted[indexPath.section]]?[indexPath.row].name
        cell.detailTextLabel?.text = contactsByFirstLetter[contactFirstLettersSorted[indexPath.section]]?[indexPath.row].phoneNumber
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsByFirstLetter[contactFirstLettersSorted[section]]?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactFirstLettersSorted.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactFirstLettersSorted[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert(number: (contactsByFirstLetter[contactFirstLettersSorted[indexPath.section]]?[indexPath.row].phoneNumber)!)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            print("Contact: \(String(describing: contactsByFirstLetter[contactFirstLettersSorted[indexPath.section]]?[indexPath.row].name)) deleted.")
            
            contactsList.remove(at: indexPath.row)
            contactsByFirstLetter.removeValue(forKey: contactFirstLettersSorted[indexPath.section])
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
    }
    
    
    
    private func alert(number: String) {
        let alert = UIAlertController(title: "Do you want to call this number?",
                                      message: number,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alert, animated: true)
    }
}

