//
//  DetailTableViewController.swift
//  RNAi
//
//  Created by Vivian Liu on 1/14/17.
//  Copyright © 2017 Vivian Liu. All rights reserved.
//

import UIKit
import SafariServices

class DetailTableViewController: UITableViewController {

    // MARK: - Properties
    var gene: Gene?
    private var savedGeneNames = UserDefaults.standard.object(forKey: ConstantString.userDefaultsKey) as? [String] ?? [String]()
    private let button = UIButton()
    
    // MARK: - IBActions
    @IBAction private func openNCBIPage(_ sender: UIButton) {
        let accessionNumber = sender.currentTitle!
        let urlPrefix = ConstantString.geneNCBIUrlPrefix
        let url = URL(string: urlPrefix + accessionNumber)
        let sfSafariVC = SFSafariViewController(url: url!)
        present(sfSafariVC, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        print(gene!)

        let vc = UIActivityViewController(activityItems: [gene?.description ?? ""], applicationActivities:[])
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        let selectedGene = gene!
        
        if !selectedGene.isSaved {
            savedGeneNames.append((gene?.geneName)!)
            UserDefaults.standard.set(savedGeneNames, forKey: ConstantString.userDefaultsKey)
        } else {
            let index = savedGeneNames.index(of: selectedGene.geneName)
            savedGeneNames.remove(at: index!)
            UserDefaults.standard.set(savedGeneNames, forKey: ConstantString.userDefaultsKey)
        }
            button.isSelected = !button.isSelected
    }
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove seperator lines from empty cells
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        setUpBarButtonItemView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedGeneNames = UserDefaults.standard.object(forKey: ConstantString.userDefaultsKey) as? [String] ?? [String]()
        button.isSelected = savedGeneNames.contains((gene?.geneName)!)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gene?.sequences.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.detailCellIdentifier, for: indexPath) as! DetailInformationTableViewCell
        cell.sequenceLabel.text = gene?.sequences[indexPath.row]
        cell.efficiencyLabel.text = ((gene?.efficiency[indexPath.row] ?? 0) * 100).roundTo2f() as String + " %"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.detailHeaderCellIdentifier) as! DetailHeaderTableViewCell
        cell.geneNameLabel.text = gene?.geneName
        cell.geneNumberButton.setTitle(gene?.accessionNumber, for: .normal)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 145
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Private Methods
    private func setUpBarButtonItemView() {
        button.setImage(UIImage(named: ConstantString.unSavedImageName), for: .normal)
        button.setImage(UIImage(named: ConstantString.savedImageName), for: .highlighted)
        button.setImage(UIImage(named: ConstantString.savedImageName), for: .selected)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(saveButtonClicked(_:)), for: .touchDown)
        let shareBarButtonItem = navigationItem.rightBarButtonItem
        let saveBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.setRightBarButtonItems([shareBarButtonItem!, saveBarButtonItem], animated: true)
        button.isSelected = savedGeneNames.contains((gene?.geneName)!)
    }
    
}


extension Double
{
    func roundTo0f() -> NSString
    {
        return NSString(format: "%.0f", self)
    }
    
    func roundTo1f() -> NSString
    {
        return NSString(format: "%.1f", self)
    }
    
    func roundTo2f() -> NSString
    {
        return NSString(format: "%.2f", self)
    }
    
    func roundToNf(n : Int) -> NSString
    {
        return NSString(format: "%.\(n)f" as NSString, self)
    }
}

