//
//  ToDoItem.swift
//  RealmTodo
//
//  Created by Brandon on 7/13/17.
//  Copyright © 2017 BrandonAubrey. All rights reserved.
//
import RealmSwift

class TodoItem: Object {
    @objc dynamic var detail = ""
    @objc dynamic var status = 0
}
