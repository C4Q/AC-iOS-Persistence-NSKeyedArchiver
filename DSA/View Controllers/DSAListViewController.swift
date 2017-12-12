//
//  ViewController.swift
//  DSA
//
//  Created by Alex Paul on 12/8/17.
//  Copyright © 2017 Alex Paul. All rights reserved.
//
import UIKit

class DSAListViewController: UIViewController {
    
    @IBOutlet weak var dsaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dsaTableView.dataSource = self
        dsaTableView.delegate = self
        DataModel.shared.load() // on first load gets the dsa list data from persistence (documents folder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dsaTableView.reloadData() // updates the table view for new dsa items on viewWillAppear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! UITableViewCell
            if let indexPath = dsaTableView.indexPath(for: cell) {
                let dsa = DataModel.shared.getLists()[indexPath.row]
                detailVC.dsa = dsa
            }
        } else if segue.identifier == "editList" {
            let navController = segue.destination as! UINavigationController
            if let editListVC = navController.viewControllers.first as? EditListViewController {
                let dsaItem = sender as! DSA
                editListVC.dsaItemToBeEdited = dsaItem
            }
            
        }
    }
}

extension DSAListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.getLists().count//dsaLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DSACell", for: indexPath)
        let dsa = DataModel.shared.getLists()[indexPath.row]
        cell.textLabel?.text = dsa.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        DataModel.shared.removeDSAItemFromIndex(fromIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension DSAListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let dsaItem = DataModel.shared.getLists()[indexPath.row]
        performSegue(withIdentifier: "editList", sender: dsaItem)
    }
}
