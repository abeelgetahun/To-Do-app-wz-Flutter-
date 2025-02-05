import 'package:to_do/models/todo.dart';
import "package:flutter/material.dart";
import "package:to_do/constants/colors.dart";
import 'package:to_do/widget/todo_item.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todosList = [];
  final TextEditingController _todoController = TextEditingController();
  static const String STORAGE_KEY = 'todos';

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  // Load todos from storage
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString(STORAGE_KEY);

    if (todosString != null) {
      final List<dynamic> decoded = jsonDecode(todosString);
      setState(() {
        todosList.clear();
        todosList.addAll(
          decoded.map((item) => ToDo.fromJson(item)).toList(),
        );
      });
    } else {
      setState(() {
        todosList.addAll(ToDo.todoList());
      });
    }
  }

  // Save todos to storage
  Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedTodos = jsonEncode(
      todosList.map((todo) => todo.toJson()).toList(),
    );
    await prefs.setString(STORAGE_KEY, encodedTodos);
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      saveTodos();
    });
  }

  void _deleteToDoItem(ToDo todo) {
    setState(() {
      todosList.remove(todo);
      saveTodos();
    });
  }

  void _addToDoItem() {
    String todoText = _todoController.text.trim();
    if (todoText.isNotEmpty) {
      setState(() {
        todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todoText,
          isDone: false,
        ));
        saveTodos();
      });
      _todoController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "All Todo's",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in todosList)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: () => _deleteToDoItem(todoo),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ✅ Add Button & Text Field
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _todoController, // Attach controller
                        decoration: InputDecoration(
                          hintText: 'Add a new todo item',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: tdGrey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addToDoItem, // Call add function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  AppBar _buildAppBar() {
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
