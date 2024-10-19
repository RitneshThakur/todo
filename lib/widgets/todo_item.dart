import 'package:flutter/material.dart';

import '../models/to_do.dart';

class toDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;
   toDoItem({super.key,required  this.todo, required this.onToDoChange, required this.onDeleteItem});

  @override
  Widget build(BuildContext home_context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(
         todo.isDone ?Icons.check_box:Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              decoration:
             todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(onPressed: (){
          onDeleteItem(todo.id);
        }, icon: Icon(Icons.delete)),
      ),
    );
  }
}
