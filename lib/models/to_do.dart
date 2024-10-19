class ToDo{
  String? id;
  String? todoText;
  bool isDone;
  ToDo({required this.id,required this.todoText,this.isDone=false});
  static List<ToDo>todoList(){
    return[
      ToDo(id: '01', todoText: 'Do homework',isDone: true),
      ToDo(id: '02', todoText: 'Go to gym',isDone: true),
      ToDo(id: '03', todoText: 'Buy Groceries'),
      ToDo(id: '04', todoText: 'Do cooking',),
      ToDo(id: '05', todoText: 'Revise Book'),

    ];
  }
}