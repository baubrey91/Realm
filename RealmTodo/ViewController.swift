//
//  ViewController.swift
//  RealmTodo
//
//  Created by Brandon on 7/13/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var todoList: Results<TodoItem> {
        get {
            return realm.objects(TodoItem.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNew(_ sender: Any) {
        
        let alertController: UIAlertController = UIAlertController(title: "New todo", message: "What do you plan to do?", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
            
        }
        
        let action_cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in
            
        }
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "Add", style: .default) { (UIAlertAction) -> Void in
            
            let textField_todo = (alertController.textFields?.first)! as UITextField
            print("You entered \(textField_todo.text)")
            let todoItem = TodoItem()
            todoItem.detail = textField_todo.text!
            todoItem.status = 0
            
            try! self.realm.write ({
                self.realm.add(todoItem)
                self.tableView.insertRows(at: [IndexPath.init(row: self.todoList.count - 1, section: 0)], with: .automatic)
            })
        }
        
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = todoList[indexPath.row]
        
        try! self.realm.write({
            item.status = (item.status == 1) ? 0 : 1
        })
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let item = todoList[indexPath.row]
        cell.titleLabel?.text = item.detail
        cell.detailLabel?.text = "\(item.status)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let item = todoList[indexPath.row]
            try! self.realm.write({
                self.realm.delete(item)
            })
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

