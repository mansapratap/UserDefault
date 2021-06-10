//
//  UserDefaultsVC.swift
//  UserDefault
//
//  Created by Mansa Pratap Singh on 21/04/21.
//

import UIKit

class UserDefaultsVC: UITableViewController {
    
    // MARK:- Properties
    var itemArray = [String]()
    var UserDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefault.array(forKey: "listArray") as? [String] {
            itemArray = data
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefault.setValue(self.itemArray, forKey: "listArray")
            tableView.reloadData()
        }
    }
    
    // MARK:- IB Actions
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "Add new items to the list.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if textField.text != "" {
                self.itemArray.append(textField.text!)
                self.UserDefault.setValue(self.itemArray, forKey: "listArray")
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (inputText) in
            inputText.placeholder = "Enter Item"
            inputText.autocapitalizationType = .words
            textField = inputText
        }
        
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}
