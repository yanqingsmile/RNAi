//
//  SavedTableViewController.swift
//  RNAi
//
//  Created by Vivian Liu on 1/18/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import UIKit

class SavedTableViewController: UITableViewController {
    
    // MARK: - Properties
    var savedGeneNames: [String?]? {
        return UserDefaults.standard.object(forKey: ConstantString.userDefaultsKey) as? [String?]
    }
    
    var genes: [Gene] {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.genes
        }
    }

    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedGeneNames?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.savedCellIdentifier, for: indexPath)
        if let savedGeneName = savedGeneNames?[indexPath.row] {
            for gene in genes {
                if gene.geneName == savedGeneName {
                    cell.textLabel?.text = gene.geneName
                    cell.detailTextLabel?.text = gene.accessionNumber
                    break
                }
            }
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.savedHeaderIdentifier)
        cell?.textLabel?.text = TextLabel.headerCellTextLabel
        cell?.detailTextLabel?.text = TextLabel.headerCellDetailTextLabel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75.0
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var savedGeneNameList = UserDefaults.standard.object(forKey: ConstantString.userDefaultsKey) as? [String]
            savedGeneNameList?.remove(at: indexPath.row)
            UserDefaults.standard.set(savedGeneNameList, forKey: ConstantString.userDefaultsKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    

    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailTableVC = segue.destination as! DetailTableViewController
        if let selectedCell = sender as? UITableViewCell {
            for gene in genes {
                if gene.geneName == selectedCell.textLabel?.text {
                    detailTableVC.gene = gene
                }
            }
        }
        // Pass the selected object to the new view controller.
    }
    

}
