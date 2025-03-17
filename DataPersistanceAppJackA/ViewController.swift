//
//  ViewController.swift
//  DataPersistanceAppJackA
//
//  Created by student on 3/11/25.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet var mainTableView: UITableView!
    var cellID = "cellID"
    
    var dataManager: NSManagedObjectContext!
    
    var listArray: [ToDoItem] = []
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        fetchData()
    }
    
    
    @IBAction func saveListButton(_ sender: Any) {
        do {
            try self.dataManager.save()
        } catch {
            print("error")
        }
        fetchData()
        
        
    }
    @IBAction func deleteItemButton(_ sender: Any) {
        guard let index = selectedIndex else { return }

        let deleteItem = listArray[index.row] // Get the selected item
        dataManager.delete(deleteItem)
        listArray.remove(at: index.row)
        mainTableView.reloadData()
        selectedIndex = nil
        
    }
    
    @IBAction func addItemButton(_ sender: Any) {
        let newItem = ToDoItem(context: dataManager)
        newItem.about = "New ToDo Item"
        newItem.status = false
        listArray.append(newItem)
        mainTableView.reloadData()
    }
    
    
    
    
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ToDoItem")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray  = result as! [ToDoItem]

            mainTableView.reloadData()
        } catch {
                print("Error retrieving data")
            }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let item = listArray[indexPath.row]
        cell.textLabel?.text = item.about
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedIndex = indexPath
        }

}

