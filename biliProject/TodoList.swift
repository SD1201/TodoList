//
//  TodoList.swift
//  biliProject
//
//  Created by 施达 on 2020/2/10.
//  Copyright © 2020 施达. All rights reserved.
//
import SwiftUI


var exampletodos: [Todo] = [
    Todo(title: "吃饭", dueDate: Date()),
    Todo(title: "看电视", dueDate: Date().addingTimeInterval(30000)),
    Todo(title: "玩游戏", dueDate: Date()),
    Todo(title: "看网课", dueDate: Date()),
    Todo(title: "睡觉", dueDate: Date())
]

struct TodoList: View {
    @ObservedObject var main: Main
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(main.todos) { todo in
                    VStack {
                        if todo.i == 0 || formatter.string(from: self.main.todos[todo.i].dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate) {
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                Text(date2Word(date: self.main.todos[todo.i].dueDate))
                                Spacer()
                            }
                        }
                        HStack {
                            Spacer().frame(width: 20)
                            TodoItem(main: self.main, todoIndex: .constant(todo.i))
                                .cornerRadius(10.0)
                                .clipped()
                                .shadow(color: Color("todoItemShadow"), radius: 5)
                            Spacer().frame(width: 25)
                        }
                        Spacer().frame(height: 20)
                    }
                }
                Spacer()
                    .frame(height: 150)
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("待办事项")
            .foregroundColor(Color("theme")))
            .onAppear {
                
                if let data = UserDefaults.standard.object(forKey: "todos") as? Data {
                    let todolist = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Todo] ?? []
                    for todo in todolist {
                        if !todo.checked {
                            self.main.todos.append(todo)
                        }
                    }
                    self.main.sort()
                } else {
                    self.main.todos = exampletodos
                    self.main.sort()
                }
            }
        }
    }
}


#if DEBUG
struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(main: Main())
        //TodoDetails()
    }
}
#endif
