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

final class ViewController: UITableViewController, CellProviding {
  
  let people = [
    Person(name: "Shaps", role: "Engineer"),
    Person(name: "Anne", role: "Content Producer")
  ]
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return cellProvider(forRowAt: indexPath, in: tableView).cell as! UITableViewCell
  }
  
  func cellProvider<D : DataView>(forRowAt indexPath: NSIndexPath, in dataView: D) -> CellProvider {
    let person = people[indexPath.item]
    
    if person.role == "Engineer" {
      return CellProvider(dataView: dataView, reuseIdentifier: PersonCell.reuseIdentifier, indexPath: indexPath, registerCell: true) {
        (cell: PersonCell) in // This is where type inference does its job
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.role
      }
    } else {
      // Here, we use the cell registered in the storyboard
      return CellProvider(dataView: dataView, reuseIdentifier: "SubtitleCell", indexPath: indexPath, registerCell: false) {
        (cell: UITableViewCell) in
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.role
      }
    }
  }
  
}

