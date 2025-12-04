//
//  TaskData.swift
//  Zad2
//
//  Created by user279431 on 12/3/25.
//

enum TaskStatus: String {
    case toDo = "to do"
    case inProgress = "in progress"
    case done = "done"
}

struct TaskData: Identifiable {
    let id: Int
    let name: String
    let image: String
    var status: TaskStatus?
}
