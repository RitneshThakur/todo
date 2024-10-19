import 'package:flutter/material.dart';
import 'package:project/models/to_do.dart';
import '../widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _searchtodo = [];
  final _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _searchtodo = todoList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              size: 30,
            ),
            Icon(
              Icons.person,
              size: 30,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            "All to do list",
                            style: TextStyle(fontSize: 30, color: Colors.blue),
                          )),
                      for (ToDo todo in _searchtodo.reversed)
                        toDoItem(
                          todo: todo,
                          onToDoChange: _toDoChange,
                          onDeleteItem: _deleteItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10,
                              spreadRadius: 0.2),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        autofocus: true,
                        controller: _textController,
                        decoration: InputDecoration(
                            hintText: "Add a new work", border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 20, bottom: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            addItem(_textController.text);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: Icon(Icons.add)))
                ],
              ),
            ),

        ],
      ),
    );
  }

  void _runfilter(String ekey) {
    List<ToDo> results = [];
    if (ekey.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(ekey.toLowerCase()))
          .toList();
    }
    setState(() {
      _searchtodo=results;
    });
  }

  void addItem(String todo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _textController.clear();
  }

  void _deleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _toDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  Container searchbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: _runfilter,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
            hintText: "search",
            border: InputBorder.none),
      ),
    );
  }
}
