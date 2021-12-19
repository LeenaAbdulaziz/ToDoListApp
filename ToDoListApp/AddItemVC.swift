//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Linah abdulaziz on 11/05/1443 AH.
//

import UIKit

class AddItemVC: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var delegate : AddItemViewControllerDelegate?
    
                
   
    
    
    @IBOutlet weak var titelTextField: UITextField!
    
    @IBOutlet weak var detailsTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func AddItemPressed(_ sender: UIButton) {
        
        if (titelTextField.text == "" ) && (detailsTextField.text == ""){
         dismiss(animated: true, completion: nil)
            
        }
        else{
            let item = ToDoListItem.init(title: titelTextField.text!, details: detailsTextField.text!, date: datePicker!.date)
        
            delegate?.itemSaved(with: item)
      
        
        dismiss(animated: true, completion: nil)
        
        }
    }
    

}


struct ToDoListItem {
    let title : String
    let details: String
    let date: Date
}
