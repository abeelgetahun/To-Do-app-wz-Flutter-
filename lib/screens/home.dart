import 'package:to_do/models/todo.dart';
import "package:flutter/material.dart";
import "package:to_do/constants/colors.dart";
import 'package:to_do/widget/todo_item.dart';


class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
   final todosList = ToDo.todoList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar() ,
      body: Container(
        padding:  EdgeInsets.symmetric(
            horizontal: 20,
          vertical: 15,

        ),
        child: Column(
          children: [
            searchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: 50,
                        bottom: 20
                    ),
                    child: Text(
                      "All Todo's",
                      style: TextStyle(
                        fontSize:30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              
                  ),
                  for (ToDo  todoo in todosList)
                    ToDoItem(todo: todoo),
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }


  AppBar _buildAppBar(){
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 30,
            width: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/profile-pic (16).png"),
            ),
          )
        ],
      ),
    );
  }
}
