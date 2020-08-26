//
//  HomeTableViewController.swift
//  MortgageCalculator
//
//  Created by Joe on 8/24/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let mortgageController = MortgageController()
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mortgageController.mortgageArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        
        let info = mortgageController.houseArray[indexPath.row]
        cell.textLabel?.text = info.address
        cell.detailTextLabel?.text = formatter.string(from: info.calculatedMortgage)
        return cell
    }
    

     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        mortgageController.saveToPersistentStore()
        mortgageController.loadFromPersistentStore()
        tableView.reloadData()
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
        
     }
     }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let indexPath = tableView.indexPathForSelectedRow, let vc = segue.destination as? HomeDetailViewController {
                vc.houseDelegate = mortgageController.houseArray[indexPath.row]
                vc.mortgageDelegate = mortgageController.mortgageArray[indexPath.row]
            }
        }
    }
}
