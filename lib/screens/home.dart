import 'package:flutter/material.dart';
import 'package:to_do/models/todo.dart';
import 'package:to_do/constants/colors.dart';
import 'package:to_do/widget/todo_item.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final List<ToDo> _todosList = [];
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  static const String STORAGE_KEY = 'todos';

  List<ToDo> _filteredTodos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchController.addListener(_filterTodos);
    loadTodos();
  }

  @override
  void dispose() {
    _todoController.dispose();
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _filterTodos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTodos = _todosList.where((todo) =>
          todo.todoText.toLowerCase().contains(query)).toList();
    });
  }

  Future<void> loadTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? todosString = prefs.getString(STORAGE_KEY);

      setState(() {
        _todosList.clear();
        if (todosString != null) {
          final List<dynamic> decoded = jsonDecode(todosString);
          _todosList.addAll(
            decoded.map((item) => ToDo.fromJson(item)).toList(),
          );
        } else {
          _todosList.addAll(ToDo.todoList());
        }
        _filteredTodos = List.from(_todosList);
        _isLoading = false;
      });
    } catch (e) {
      _showErrorSnackBar('Failed to load todos');
      setState(() => _isLoading = false);
    }
  }

  Future<void> saveTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedTodos = jsonEncode(
        _todosList.map((todo) => todo.toJson()).toList(),
      );
      await prefs.setString(STORAGE_KEY, encodedTodos);
    } catch (e) {
      _showErrorSnackBar('Failed to save todos');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleToDoChange(ToDo todo) async {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    await saveTodos();
  }

  Future<void> _deleteToDoItem(ToDo todo) async {
    setState(() {
      _todosList.remove(todo);
      _filterTodos();
    });
    await saveTodos();

    // Show undo option
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Todo deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            setState(() {
              _todosList.add(todo);
              _filterTodos();
            });
            await saveTodos();
          },
        ),
      ),
    );
  }

  Future<void> _addToDoItem() async {
    String todoText = _todoController.text.trim();
    if (todoText.isNotEmpty) {
      final newTodo = ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: todoText,
        isDone: false,
      );

      setState(() {
        _todosList.add(newTodo);
        _filterTodos();
      });
      await saveTodos();
      _todoController.clear();

      // Animate the new item
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _buildSearchBox(),
                Expanded(
                  child: _filteredTodos.isEmpty
                      ? _buildEmptyState()
                      : _buildTodoList(),
                ),
              ],
            ),
          ),
          _buildAddTodoBar(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_alt_outlined, size: 70, color: tdGrey),
          const SizedBox(height: 20),
          Text(
            _searchController.text.isEmpty
                ? 'No todos yet. Add your first todo!'
                : 'No matching todos found',
            style: TextStyle(color: tdGrey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _filteredTodos.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            child: const Text(
              "All Todo's",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          );
        }

        final todo = _filteredTodos[index - 1];
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(_animationController),
          child: ToDoItem(
            todo: todo,
            onToDoChanged: _handleToDoChange,
            onDeleteItem: () => _deleteToDoItem(todo),
          ),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          border: InputBorder.none,
          hintText: 'Search todos...',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  Widget _buildAddTodoBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo item',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _addToDoItem,
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: tdBlack, size: 30),
            onPressed: () {
              // Implement menu functionality
            },
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/profile-pic (16).png"),
          ),
        ],
      ),
    );
  }
}