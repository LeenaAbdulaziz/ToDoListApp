//
//  TableViewController.swift
//  ToDoListApp
//
//  Created by Linah abdulaziz on 11/05/1443 AH.
//

import UIKit
import CoreData


class ViewController: UITableViewController, AddItemViewControllerDelegate  {
   
   
    

   var savedItem = (UIApplication.shared.delegate as! AppDelegate).saveContext


    var list = [ToDoItem]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllItem()
       
        tableView.rowHeight = 150
        
        
        
        
    }
    

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for :indexPath) as! CustomCell
        
        let item = list[indexPath.row]
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        cell.dateLabel?.text = dateFormatter.string(from: item.date!)
        cell.titelLabel?.text = item.titel
        cell.DetailsLabel?.text = item.details
        
        if  item.checkMark == true {
                  
                 cell.accessoryType = .checkmark
                    
                }
                else{
                    cell.accessoryType = .none
                }
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        item.checkMark = true
        
        
         
    savedItem()
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        
        deleteItem(item: item)
        
    }
    
    func deleteItem(item: ToDoItem) {
        let contex = getContext()
    
        contex.delete(item)
        
        do{
            try contex.save()
        }
        catch{
            print("\(error)")
        }
        
        
        fetchAllItem()
    }
    
    
    func fetchAllItem(){
        
        let context = getContext()
        let request = NSFetchRequest<ToDoItem> (entityName: "ToDoItem")
        
        do{
            list = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            print("\(error)")
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           let destination = segue.destination as! AddItemVC
           destination.delegate = self
           
           
       }
    
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext // snapshot of all app data stored in core data database
    }
    
    func itemSaved( with object: ToDoListItem) {

        print("Recieved ")

        let context = getContext()
        
        
        
        let item = ToDoItem.init(context: context)
        
        item.titel = object.title
        item.details = object.details
        item.date = object.date
        item.checkMark = false
        
          
        
       // debugPrint(item.titel!)
        
        do{
            try context.save()
            
            fetchAllItem()
            
        }
        catch{
            print("\(error)")
        }
        
       
        
    }
    

}

//extension ViewController {
//    func getContext() -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext // snapshot of all app data stored in core data database
//    }
//
//    func saveTask(task: Task) {
//        //1. get updated app context
//        let context = getContext()
//
//        //2. Creating NSManagedObject
//        let taskItem = TaskEntity.init(context: context) // important
//        taskItem.name = task.name
//        taskItem.id = task.id
//
//        //3. save context
//        do {
//            try context.save()
//        } catch {
//            // error handling
//            print(error.localizedDescription)
//        }
//    }
//
//    func getTask() {
//        let context = getContext()
//
//        let request = NSFetchRequest<TaskEntity>.init(entityName: "TaskEntity")
//
//        do {
//            taskItemArr = try context.fetch(request)
//            tableView.reloadData()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func updateTask(oldTaskName:String, newTaskName: String) {
//        let context = getContext()
//
//        // update the task item array
//        let request = NSFetchRequest<TaskEntity>.init(entityName: "TaskEntity")
//
//        // query or filter
//        let predicate = NSPredicate.init(format: "name = %@", oldTaskName)
//        let predicate2 = NSPredicate.init(format: "name == %@", "")
//        let compoundPredicate = NSCompoundPredicate.init(orPredicateWithSubpredicates: [predicate, predicate2])
//        request.predicate = compoundPredicate
//        do {
//            if let taskItem = try context.fetch(request).first {
//                taskItem.name = newTaskName
//                try context.save()
//                getTask()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func delete(taskName:String) {
//        let context = getContext()
//
//        // update the task item array
//        let request = NSFetchRequest<TaskEntity>.init(entityName: "TaskEntity")
//
//        // query or filter
//        let predicate = NSPredicate.init(format: "name = %@", taskName)
//        request.predicate = predicate
//
//        do {
//            if let taskItem = try context.fetch(request).first {
//                context.delete(taskItem)
//                getTask()
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//
//
