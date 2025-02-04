import 'package:to_do/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';

class ToDoItem extends StatelessWidget{

  final ToDo todo;
  const ToDoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          print("click on to do item");
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
          leading: Icon(Icons.check_box,color: tdBlue,
          ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: tdBlack,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              print("delete item clicked");
            },
          )
        ),
      )
    );
  }
}