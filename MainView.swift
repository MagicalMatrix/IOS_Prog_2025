//
//  MainView.swift
//  Zad2
//
//  Created by user279431 on 12/3/25.
//

import SwiftUI

struct MainView: View {
    
    func testFunc()
    {
    }
    
    //here comes array list
    @State private var tasks =
    [
        TaskData(id: 0, name: "maslo", image: "maslo", status: TaskStatus.toDo),
        TaskData(id: 1, name: "mleko", image: "mleko", status: TaskStatus.toDo),
        TaskData(id: 2, name: "banany", image: "banany", status: TaskStatus.toDo)
    ]
    
    
    var body: some View
    {
        List($tasks) {
            $task in VStack{
                HStack {
                    Text(task.name)
                        .font(.headline)
                }
                HStack{
                    Image(task.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:64, height:64)

                    Menu(task.status?.rawValue ?? ""){
                        Button(TaskStatus.toDo.rawValue, action: {
                            task.status = TaskStatus.toDo
                        })
                        Button(TaskStatus.inProgress.rawValue, action: {
                            task.status = TaskStatus.inProgress
                        })
                        Button(TaskStatus.done.rawValue, action: {
                            task.status = TaskStatus.done
                        })
                    }
                    //showcasing current status visually (to do later)
                    
                    
                }
            }
            
            .swipeActions(edge: .trailing)
        {
            Button(role: .destructive, action: {
                if let current = tasks.firstIndex(where: {$0.id == task.id})
                {
                    tasks.remove(at: current)
                }
            })
            {
                Label("remove?", systemImage: "trash")

            }
        }
            
        }



    }
}




#Preview {
    MainView()
}

/*
List($tasks)
{ $task in NavigationLink (destination: TaskView(task: $task), label: <#T##() -> View#>)
    
    
    Text(task.name)
        .swipeActions(edge: .trailing)
    {
        Button(role: .destructive, action: {
            if let current = tasks.firstIndex(where: {$0.id == task.id})
            {
                tasks.remove(at: current)
            }
        })
        {
            Label("remove?", systemImage: "trash")

        }
    }
}
*/
