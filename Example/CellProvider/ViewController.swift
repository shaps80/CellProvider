//
//  ViewController.swift
//  GenericCells
//
//  Created by Shaps Mohsenin on 06/08/2016.
//  Copyright © 2016 Snippex. All rights reserved.
//

import UIKit
import CellProvider

struct Person {
    let name: String
    let role: String
}

final class PersonCell: UITableViewCell { }

final class ViewController: UITableViewController {
    
    let people = [
        Person(name: "Shaps", role: "Engineer"),
        Person(name: "Anne", role: "Content Producer")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath = IndexPath(row: 0, section: 0)
        
        tableView.register(cellClass: PersonCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.item]
        
        if person.role == "Engineer" {
            let cell = tableView.dequeueReusableCell(ofType: PersonCell.self, for: indexPath)
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = person.role
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: "SubtitleCell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = person.role
            return cell
        }
    }
    
}

