//
//  SecondViewController.swift
//  TableViewStarter
//
//  Created by reromac on 2023-01-11.
//

import UIKit
//
//
//struct Contact {
//    let name: String
//    let numbers: String
//}
//
//var contacts: [Contact] = [Contact(name: "A", numbers: "123"), Contact(name: "B", numbers: "345")]
//
//
//class SecondViewController: UIViewController {
//
//
//
//
//    @IBOutlet weak var tableView: UITableView!
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.rowHeight = 75
//        
//
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell2")
//
//    }
//
//}
//
//extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell2", for: indexPath)
//        cell.textLabel?.text = contacts[indexPath.row].name
//        cell.detailTextLabel?.text = contacts[indexPath.row].numbers
//
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//}
