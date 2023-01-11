//
//  ContactTableViewController.swift
//  Task0110
//
//  Created by Dmitrij Aneicik on 2023-01-10.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    
    var contacts: [Contact] = []
    //    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for line in tupleArray {
            let name = line.0
            let phone = line.1
            let contact = Contact(name: name, phone: phone)
            contacts.append(contact)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        sections[section].header
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.textLabel?.font = .systemFont(ofSize: 18)
        
        cell.detailTextLabel?.text = contacts[indexPath.row].phone
        cell.detailTextLabel?.font = .systemFont(ofSize: 13)
        
        return cell
    }
    
    //MARK: tableView actions
    
    //swipe to delete contact
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //call contact
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "CALL contact?", message: "", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            print("Calling \(self.contacts[indexPath.row].phone)")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
}
