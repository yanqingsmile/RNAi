//
//  MasterTableViewController.swift
//  RNAi
//
//  Created by Vivian Liu on 1/13/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import UIKit
import iAd

class MasterTableViewController: UITableViewController {

    // MARK: - Properties
    var genes: [Gene] {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.genes
        }
    }
    var filtedGenes = [Gene]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        canDisplayBannerAds = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search from \(genes.count) genes"
        searchController.searchBar.delegate = self
        
        
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filtedGenes.count
        } else {
            return genes.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.masterGeneCellIdentifier , for: indexPath)
        let gene: Gene
        if searchController.isActive && searchController.searchBar.text != "" {
            gene = filtedGenes[indexPath.row]
        } else {
            gene = genes[indexPath.row]
        }

        cell.textLabel?.text = gene.geneName
        cell.detailTextLabel?.text = gene.accessionNumber
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.masterHeaderCellIdentifier)
        cell?.textLabel?.text = TextLabel.headerCellTextLabel
        cell?.detailTextLabel?.text = TextLabel.headerCellDetailTextLabel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75.0
    }

    
    // MARK: - Methods
    func filterContentForSearchText(searchText: String) {
        filtedGenes = genes.filter{ $0.geneName.lowercased().contains(searchText.lowercased()) || $0.accessionNumber.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    

    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetailFromMasterToDetail {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailTableViewController = segue.destination as! DetailTableViewController
                let gene: Gene
                if searchController.isActive && searchController.searchBar.text != "" {
                    gene = filtedGenes[indexPath.row]
                } else {
                    gene = genes[indexPath.row]
                }
                detailTableViewController.gene = gene
            }
        }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

// MARK: - Delegation Methods
extension MasterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension MasterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
